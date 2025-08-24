{ config,pkgs,... }:

{
  # los imports te permiten incluir otros módulos de configuración
  imports=[ ./hardware-configuration.nix];

  # boot configura el gestor de arranque
  boot.loader.grub.enable=true;
  boot.loader.grub.device="/dev/vda";
  boot.loader.grub.useOSProber = true;

  # permitimos paquetes no libres
  nixpkgs.config.allowUnfree=true;

  # configuración de red
  networking.hostName="nixos";
  networking.networkmanager.enable=true;

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
  	displayManager.lightdm.enable=true;
    windowManager.i3.package=pkgs.i3-gaps;
    windowManager.i3.enable=true;
	videoDrivers = [ "modesetting" ];
	displayManager.sessionCommands = ''
	xrandr --output Virtual-1 --mode 1920x1200
	'';
  };

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

  programs.firefox.enable=true;

  environment.systemPackages = with pkgs; [
    home-manager
    firefox vscodium
    i3 i3status dmenu xterm alacritty
    
    git
];

  system.stateVersion="25.05";
}
