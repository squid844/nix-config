{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  perSystem = { pkgs, lib, self', ... }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs; # THIS PART IS VERY IMPORTAINT, I FORGOT IT IN THE VIDEO!!!
      settings = {
        spawn-at-startup = [
          "noctalia-shell"
	];
	
	prefer-no-csd = null;
        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        input.keyboard.xkb.layout = "fr";

        layout.gaps = 2;
	input.touchpad.natural-scroll = null ;
	binds = {
          "Mod+Return".spawn = "kitty";
          "Mod+Q".close-window = null;
          "Mod+S".spawn-sh = "noctalia-shell ipc call launcher toggle";
        };
      };
    };
  };
}
