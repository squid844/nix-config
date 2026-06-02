{self, inputs, ... } : {
  flake.homeModules.nautilus = { pkgs, lib, ... }: {
    enable = true;
    packages = self.packages.${pkgs.stdenv.hostPlatform.system}.nautilus;
  };

  perSystem = { pkgs, lib, self', ... }: {
    packages.nautilus = inputs.wrappers-modules.wrappers.nautilus.wrap {
      inherit pkgs;
    };
  };
}
