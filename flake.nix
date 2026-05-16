{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

#    niri-flake = {
#      url = "github:sodiboo/niri-flake";
#      inputs.nixpkgs.follows = "nixpkgs";
#    };
  };

  outputs = { self, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      imports = [
        ./hosts/default/configuration.nix
        ./hosts/default/hardware-configuration.nix
        ./modules/nixos/niri.nix
        ./modules/nixos/noctalia.nix
      ];

      flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs self; };
        modules = [
          self.nixosModules.myMachineConfiguration
          self.nixosModules.myMachineHardware
          inputs.home-manager.nixosModules.default
        ];
      };
    };
}
