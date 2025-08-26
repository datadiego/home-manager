{ config,pkgs,... }:

{
  # los imports te permiten incluir otros módulos de configuración
  imports=[ ./hardware-configuration.nix];

  # boot configura el gestor de arranque
  boot.loader.grub.enable=true;
  boot.loader.grub.device="/dev/vda";
  boot.loader.grub.useOSProber = true;
  boot.loader.systemd-boot.configurationLimit = 3;
  services.upower.enable = true;
  boot.kernelParams = [ "video=1920x1200" ];
  boot.loader.grub.gfxmodeEfi = "1920x1200";


  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 3d";
  };

  # permitimos paquetes no libres
  nixpkgs.config.allowUnfree=true;

networking.hostName = "nixos";
networking.networkmanager.enable = false;

networking.interfaces.lan0 = {
  useDHCP = false;
  ipv4.addresses = [ {
    address = "192.168.100.17";
    prefixLength = 24;
  } ];
};

networking.defaultGateway = "192.168.100.1";
networking.nameservers = ["1.1.1.1" "8.8.8.8"];

services.udev.extraRules = ''
  SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="52:54:00:5c:7c:74", NAME="lan0"
'';


  # configuracion de idioma y localización
  time.timeZone="Europe/Madrid";
  i18n.defaultLocale="es_ES.UTF-8";
  i18n.extraLocaleSettings={
    LC_ADDRESS="es_ES.UTF-8";
    LC_IDENTIFICATION="es_ES.UTF-8";
    LC_MEASUREMENT="es_ES.UTF-8";
    LC_MONETARY="es_ES.UTF-8";
    LC_NAME="es_ES.UTF-8";
    LC_NUMERIC="es_ES.UTF-8";
    LC_PAPER="es_ES.UTF-8";
    LC_TELEPHONE="es_ES.UTF-8";
    LC_TIME="es_ES.UTF-8";
  };

  # configuración de escritorio
  services.xserver = {
  	enable=true;
  	#desktopManager.xfce.enable=false;
  	displayManager.lightdm.enable=false;
    windowManager.i3.package=pkgs.i3-gaps;
    windowManager.i3.enable=true;
	  videoDrivers = [ "modesetting" ];
	  displayManager.sessionCommands = ''
	  xrandr --output Virtual-1 --mode 1920x1200
	  '';
  };
  services.displayManager.ly.enable=true;


  # configuración del teclado
  services.xserver.xkb={
    layout="es";
    variant="";
  };
  # configuración de la consola
  console.keyMap="es";

  # configuración de impresión
  services.printing.enable=true;

  # configuración de audio
  services.pulseaudio.enable=false;
  security.rtkit.enable=true;
  services.pipewire={
    enable=true;
    alsa.enable=true;
    alsa.support32Bit=true;
    pulse.enable=true;
  };

  # configuración de entrada
  services.libinput.enable=true;

  users.users.datadiego={
    isNormalUser=true;
    description="diego";
    extraGroups=[ "networkmanager" "wheel"];
  };

systemd.timers."download-hn" = {
  wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5m";
      OnUnitActiveSec = "5m";
      Unit = "download-hn.service";
    };
};

systemd.services."download-hn" = {
  script = ''
    set -eu
    ${pkgs.wget}/bin/wget -O /tmp/hn.xml https://hnrss.org/newest?q=hacking+OR+exploit
  '';
  serviceConfig = {
    Type = "oneshot";
    User = "root";
  };
};

  programs.firefox.enable=true;

  environment.systemPackages = with pkgs; [
    home-manager
    wget
    firefox
    i3 i3blocks i3status dmenu xterm alacritty
    git
    suricata
];

  system.stateVersion="25.05";
}
