{ self, inputs, ... }: {
  flake.homeModules = {
    kitty = { pkgs, lib, ... }: {
      programs.kitty = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.myKitty;
        shellIntegration.enableZshIntegration = true;
      };
      home.packages = [ pkgs.nerd-fonts.jetbrains-mono ];
    };

    vscodium = { pkgs, lib, ... }: {
      programs.vscodium = {
        enable = true;
        package = pkgs.vscodium;
	extensions = with pkgs.vscode-extensions; [
	  jnoortheen.nix-ide
	  ms-vscode.cpptools
	];
      };
    };
  };
}
