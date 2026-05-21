{ self, inputs, ... } : {
  perSystem = { pkgs, lib, self', ... }: {
    packages.yazi = inputs.wrapper-modules.wrappers.yazi.wrap {
      inherit pkgs;
      settings = {
      };
    };
  };
}
