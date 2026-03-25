{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-yazi-plugins = {
      url = "github:lordkekz/nix-yazi-plugins";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    apple-fonts = {
      url = "github:Lyndeno/apple-fonts.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;

      hosts = {
        lenovo = {
          system = "x86_64-linux";
          username = "drama";
          userModule = ./users/drama;
        };

        # Future host example.
        # Enable this once ./hosts/desktop and the user module exist.
        desktop = {
          system = "x86_64-linux";
          username = "drama";
          userModule = ./users/drama;
        };
      };

      mkHost = hostname:
        let
          host = hosts.${hostname};
        in
        lib.nixosSystem {
          inherit (host) system;

          specialArgs = {
            inherit inputs hostname;
            username = host.username;
          };

          modules = [
            ./hosts/${hostname}

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.extraSpecialArgs = {
                inherit inputs hostname;
                username = host.username;
              };

              home-manager.users.${host.username} =
                import host.userModule;
            }
          ];
        };
    in {
      nixosConfigurations = {
        lenovo = mkHost "lenovo";

        # Uncomment when the host path exists:
        # desktop = mkHost "desktop";
      };
    };
}
