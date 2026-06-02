{ self, inputs, ... }:

{
  flake.nixosModules.myMachineConfiguration = { pkgs, lib, ... }: {

  imports = [
    self.nixosModules.myMachineHardware
    self.nixosModules.niri
    self.nixosModules.nautilus
    ./main-user.nix
  ];

  # Main user
  main-user.enable = true;
  main-user.userName = "n";

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Réseau
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Timezone / locale
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS        = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT    = "fr_FR.UTF-8";
    LC_MONETARY       = "fr_FR.UTF-8";
    LC_NAME           = "fr_FR.UTF-8";
    LC_NUMERIC        = "fr_FR.UTF-8";
    LC_PAPER          = "fr_FR.UTF-8";
    LC_TELEPHONE      = "fr_FR.UTF-8";
    LC_TIME           = "fr_FR.UTF-8";
  };

  # Clavier
  services.xserver.xkb = {
    layout  = "fr";
    variant = "azerty";
  };
  console.keyMap = "fr";

  # Son
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable            = true;
    alsa.enable       = true;
    alsa.support32Bit = true;
    pulse.enable      = true;
  };

  # Impression
  services.printing.enable = true;

  # Paquets système
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    neovim
    wget
    firefox
    git
    greetd.tuigreet
    noctalia-shell
    upower # for battery display
    polkit_gnome
#    pkgs.ankama-launcher
  ];

  programs.firefox.enable = true;

  # Home Manager
  home-manager = {
    extraSpecialArgs = { inherit inputs self; };
    backupFileExtension = "backup";
    users."n" = import ./home.nix;
  };
  
  # Demarage
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd niri-session";
	user = "greeter";
      };
      initial-session ={
        command =  "niri-session";
        user = "n";
      };
    };
  };
  
  # Authentification pour apps graphiques
  security.polkit.enable = true;
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
  # Power management for noctalia
  services.upower.enable = true;
  # Ne pas toucher
  system.stateVersion = "25.11";
  };
}
