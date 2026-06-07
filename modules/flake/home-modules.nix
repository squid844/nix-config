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
      home.packages = [
      (pkgs.vscode-with-extensions.override {
        vscode = pkgs.vscodium;
	      vscodeExtensions = with pkgs.vscode-extensions; [
	        jnoortheen.nix-ide
	        ms-vscode.cpptools
          geequlim.godot-tools
          ms-dotnettools.csharp
          ms-dotnettools.vscode-dotnet-runtime
          vscodevim.vim
	      ];
	   })
    ];
    xdg.configFile."VSCodium/User/settings.json".text = builtins.toJSON {
      "dotnetAcquisitionExtension.existingDotnetPath" = [
        {
          "extensionId" = "ms-dotnettools.csharp";
          "path" = "${pkgs.dotnetCorePackages.dotnet_8.sdk}/bin";
        }
        {
          "extensionId" = "ms-dotnettools.vscode-dotnet-runtime";
          "path" = "${pkgs.dotnetCorePackages.dotnet_8.sdk}/bin";
        }
      ];
      "dotentAcquisitionExtension.allowInvalidPaths" = true;
      "godotTools.lsp.serverPort" = 6005;
    };
  };

  godot = { pkgs, lib, ... } : {
    home.packages = [ 
      pkgs.godot-mono 
      pkgs.dotnetCorePackages.dotnet_8.sdk
      ];

      home.sessionVariables = {
        DOTNET_ROOT = "${pkgs.dotnetCorePackages.dotnet_8.sdk}";
      };
  };

  firefox = { pkgs, lib, ... } : {
    programs.firefox = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.firefox;
    };
  };
};
}
