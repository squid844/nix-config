{ self, inputs, ... } : {
  perSystem = { pkgs, lib, self', ... }: {
    packages.myKitty = inputs.wrapper-modules.wrappers.kitty.wrap {
      inherit pkgs;
      settings = {
  	theme = "Tokyo Night";
        background_opacity = 0.8;
      };
    };
  };
}
