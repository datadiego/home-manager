{ config,pkgs,... }:

{
  imports=[ 
    ./hardware-configuration.nix 
    ./bootloader.nix
    ./networking-basic.nix
    ./lang.nix
    ./desktop-i3.nix
    ./audio.nix
    ];

  services.upower.enable = true;
  nixpkgs.config.allowUnfree=true;
  services.printing.enable=true;
  services.libinput.enable=true;

  users.users.datadiego={
    isNormalUser=true;
    description="El usuario que administra el sistema";
    extraGroups=[ "networkmanager" "wheel"];
  };

  environment.systemPackages = with pkgs; [
    home-manager
    wget
    firefox
    i3 i3blocks i3status dmenu xterm alacritty
    git
  ];
  programs.firefox.enable=true;

  system.stateVersion="25.05";
}
