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

	prefer-no-csd = {};
	xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        input.keyboard.xkb.layout = "fr";

        layout = {
	  gaps = 4;
          always-center-single-column = {};	
	  focus-ring = {
            width = 1.0;
	    active-color   = "#7fff7f";
	    inactive-color = "#505050";
	  };
	  preset-column-widths = [
		{ proportion = 0.33333; }
		{ proportion = 0.5; }
		{ proportion = 0.66667; }
	  ];
	};

	input.touchpad.natural-scroll = {};
	binds = {
          "Mod+Return".spawn = "kitty";
          "Mod+Q".close-window = {};
          "Mod+Space".spawn-sh = "noctalia-shell ipc call launcher toggle";
	  "Mod+Escape".spawn-sh = "noctalia-shell ipc call sessionMenu toggle";
	  "Mod+Left".focus-column-left   = {};
	  "Mod+Right".focus-column-right = {};
	  "Mod+Up".focus-window-or-workspace-up     = {};
	  "Mod+Down".focus-window-or-workspace-down = {};

	  "Mod+CTRL+Left".move-column-left   = {};
	  "Mod+CTRL+Right".move-column-right = {};
	  "Mod+CTRL+Up".move-window-up-or-to-workspace-up       = {};
	  "Mod+CTRL+Down".move-window-down-or-to-workspace-down = {};
	  "Mod+F".maximize-column = {};
	  "Mod+R".switch-preset-column-width = {};
        };
      };
    };
  };
}
