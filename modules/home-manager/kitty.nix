{ self, inputs, ... } : {
  perSystem = { pkgs, lib, self', ... }: {
    packages.myKitty = inputs.wrapper-modules.wrappers.kitty.wrap {
      inherit pkgs;
      settings = {
        background_opacity = 0.5;
	confirm_os_windows_close = false;
      };
    };
  };
}
