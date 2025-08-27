{ config, pkgs, ... }:

{
  imports =[ ./hardware-configuration.nix ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;
  boot.loader.systemd-boot.configurationLimit = 3;
  services.upower.enable = true;
  boot.kernelParams = [ "video=1920x1200" ];
  boot.loader.grub.gfxmodeEfi = "1920x1200";

  services.xserver = {
    enable=true;
    windowManager.i3.package=pkgs.i3-gaps;
    windowManager.i3.enable=true;
    videoDrivers = [ "modesetting" ];
    displayManager.sessionCommands = ''
    xrandr --output Virtual-1 --mode 1920x1200
    '';
  };
  services.displayManager.ly.enable=true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Madrid";

  i18n.defaultLocale = "es_ES.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  services.xserver.xkb = {
    layout = "es";
    variant = "";
  };

  console.keyMap = "es";

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

  };

  users.users.datadiego = {
    isNormalUser = true;
    description = "datadiego";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    home-manager
  ];

  system.stateVersion = "25.05"; # Did you read the comment?

}
