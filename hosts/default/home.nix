{ config, pkgs, inputs, self, ... }:

{
  imports = [ 
    self.homeModules.kitty
    self.homeModules.vscodium
    ];

  home.username    = "n";
  home.homeDirectory = "/home/n";
  home.stateVersion = "25.11";

  # Paquets utilisateur
  home.packages = with pkgs; [
    # outils courants
    ripgrep
    fd
    bat
    eza
  ];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      size = 10000;
      ignoreDups = true;
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "kitty";
    # niri est Wayland-natif, ces variables sont importantes
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };
  programs.home-manager.enable = true;
}
