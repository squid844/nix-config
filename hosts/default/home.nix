{ config, pkgs, inputs, self, ... }:

{
  imports = [ ];

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

  programs.kitty = {
    enable = true;
    package = self.packages.${pkgs.stdenv.hostPlatform.system}.myKitty;
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
