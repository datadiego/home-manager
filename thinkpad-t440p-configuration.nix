{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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

  users.users.datadiego = {
    isNormalUser = true;
    description = "datadiego";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
  services.xserver = {
  enable = true;
  displayManager.lightdm.enable=true;
  windowManager.i3.package=pkgs.i3-gaps;
  windowManager.i3.enable=true;
  videoDrivers = [ "modesetting" ];
  displayManager.sessionCommands = ''
  xrandr --output Virtual-1 --mode 1920x1200
  '';
  };  

  environment.systemPackages = with pkgs; [
  firefox
  home-manager
  i3 i3blocks i3status dmenu xterm alacritty
  git gh
  vscodium
  ];

  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  
  system.stateVersion = "25.05";

}
#  boot.loader.systemd-boot.configurationLimit = 3;

 # nix.gc = {
 #  automatic = true;
 #   dates = "daily";
 #   options = "--delete-older-than 3d";
 # };

#  nixpkgs.config.allowUnfree=true;


  # configuración de escritorio
#  services.xserver = {
#  	enable=true;
  	#desktopManager.xfce.enable=false;
#  	displayManager.lightdm.enable=true;
#        windowManager.i3.package=pkgs.i3-gaps;
#        windowManager.i3.enable=true;
#	videoDrivers = [ "modesetting" ];
#	displayManager.sessionCommands = ''
#	xrandr --output Virtual-1 --mode 1920x1200
#	'';
#  };

