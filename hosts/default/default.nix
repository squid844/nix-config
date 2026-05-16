{ self, inputs, ... }: {
  
  flake.nixosConfugrations.myMachine = inputs.nixpgs.lib.nixosSystem {
    modules = [
      self.nixosModules.myMachineConfiguration
    ];
  };
}
