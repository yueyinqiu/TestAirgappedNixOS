{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nur,
      ...
    }:
    {
      nixosConfigurations.server = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./server ];
      };

      nixosConfigurations.client = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          nur = nur.legacyPackages."x86_64-linux".repos;
        };
        modules = [ ./client ];
      };
      
      homeConfigurations.home = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [ ./home ];
      };
    };
}
