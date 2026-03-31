{
  inputs = {
    self.submodules = true;
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

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

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, quickshell, ... }:
    let
      lib = nixpkgs.lib;
      mkPkgs = system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      hosts = {
        lenovo = {
          system = "x86_64-linux";
          username = "horrid";
          userModule = ./users/horrid;
        };
      };

      homes = {
        "drama@desktop" = {
          system = "x86_64-linux";
          username = "drama";
          hostname = "desktop";
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
      mkHome = name:
        let
          home = homes.${name};
        in
        home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs home.system;

          extraSpecialArgs = {
            inherit inputs;
            inherit (home) hostname username;
          };

          modules = [
            home.userModule
          ];
        };
    in {
      nixosConfigurations = {
        lenovo = mkHost "lenovo";
      };

      homeConfigurations = {
        "drama@desktop" = mkHome "drama@desktop";
      };
    };
}
