{ self, inputs, ... } : {
  flake.nixosModules.kitty = { pkgs, lib, ... }: {
    programs.kitty = {
    enable = true;
    package = self.packages.${pkgs.stdenv.hostPlatform.system}.myKitty;
    };
  };

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
