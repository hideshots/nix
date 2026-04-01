{
  description = "drama's dotfiles";

  inputs = {
    self.submodules = true;
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    helium = {
      url = "github:schembriaiden/helium-browser-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
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

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      inherit (nixpkgs) lib;

      nixpkgsConfig = {
        allowUnfree = true;
      };

      nixosHosts = {
        lenovo = {
          system = "x86_64-linux";
          username = "horrid";
          homeModule = ./users/horrid;
        };
      };

      standaloneHomes = {
        "drama@desktop" = {
          system = "x86_64-linux";
          username = "drama";
          hostname = "desktop";
          homeModule = ./users/drama;
        };
      };

      supportedSystems = lib.unique (
        map (entry: entry.system) (
          lib.attrValues nixosHosts ++ lib.attrValues standaloneHomes
        )
      );

      mkPkgs = system:
        import nixpkgs {
          inherit system;
          config = nixpkgsConfig;
        };

      pkgsFor = lib.genAttrs supportedSystems mkPkgs;

      mkSpecialArgs =
        { username, hostname ? null }:
        {
          inherit inputs username;
        }
        // lib.optionalAttrs (hostname != null) { inherit hostname; };

      mkHomeManagerModule =
        { username, homeModule, hostname ? null }:
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = mkSpecialArgs { inherit username hostname; };
            users.${username}.imports = [ homeModule ];
          };
        };

      mkNixosHost =
        hostname:
        {
          system,
          username,
          homeModule,
        }:
        lib.nixosSystem {
          inherit system;

          specialArgs = mkSpecialArgs { inherit username hostname; };

          modules = [
            {
              nixpkgs.config = nixpkgsConfig;
            }
            ./hosts/${hostname}
            home-manager.nixosModules.home-manager
            (mkHomeManagerModule { inherit username homeModule hostname; })
          ];
        };

      mkStandaloneHome =
        _:
        {
          system,
          username,
          hostname ? null,
          homeModule,
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor.${system};

          extraSpecialArgs = mkSpecialArgs { inherit username hostname; };

          modules = [ homeModule ];
        };

      mkCheckName = prefix: name:
        "${prefix}-${lib.replaceStrings [ "@" ] [ "-" ] name}";

      checksFor = system:
        let
          hostsForSystem = lib.filterAttrs (_: host: host.system == system) nixosHosts;
          homesForSystem = lib.filterAttrs (_: home: home.system == system) standaloneHomes;
        in
        (lib.mapAttrs'
          (hostname: _:
            lib.nameValuePair
              (mkCheckName "nixos" hostname)
              self.nixosConfigurations.${hostname}.config.system.build.toplevel
          )
          hostsForSystem)
        // (lib.mapAttrs'
          (name: _:
            lib.nameValuePair
              (mkCheckName "home" name)
              self.homeConfigurations.${name}.activationPackage
          )
          homesForSystem);
    in
    {
      formatter = lib.genAttrs supportedSystems (system: pkgsFor.${system}.alejandra);
      checks = lib.genAttrs supportedSystems checksFor;
      nixosConfigurations = lib.mapAttrs mkNixosHost nixosHosts;
      homeConfigurations = lib.mapAttrs mkStandaloneHome standaloneHomes;
    };
}
