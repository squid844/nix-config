{ lib, config, pkgs, ... }:

let
  cfg = config.main-user;
in
{
  options.main-user = {
    enable   = lib.mkEnableOption "enable user module";
    userName = lib.mkOption {
      default     = "mainuser";
      type        = lib.types.str;
      description = "Nom d'utilisateur principal";
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.${cfg.userName} = {
      isNormalUser    = true;
      initialPassword = "changeme";
      description     = "Main user";
      extraGroups     = [ "networkmanager" "wheel" "video" "input" ];
      shell           = pkgs.zsh;
    };

    programs.zsh.enable = true;
  };
}
