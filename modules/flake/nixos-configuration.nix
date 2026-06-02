{ self, inputs, ... }: {
  systems = [ "x86_64-linux" ];

  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs self; };
    modules = [
      self.nixosModules.myMachineConfiguration
      self.nixosModules.myMachineHardware
      inputs.home-manager.nixosModules.default
    ];
  };
}
