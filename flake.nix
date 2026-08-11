{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
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
    };
}
