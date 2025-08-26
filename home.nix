{ config, pkgs, ... }:

let 
  cyberPackages = import ./modules/cyber-packages.nix { inherit pkgs; };
  nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") { inherit pkgs; };
in 
{
  home.username = "datadiego";
  home.homeDirectory = "/home/datadiego";
  home.enableNixpkgsReleaseCheck = false;
  home.stateVersion = "24.11"; 

# Paquetes
  home.packages = [
    pkgs.xmlstarlet
	  pkgs.feh
  	pkgs.xclip
    pkgs.jq
    pkgs.tree
	  pkgs.micro
    pkgs.xxd
    pkgs.curl
    pkgs.wget
	  pkgs.vscodium
	  pkgs.rofi
	  pkgs.alacritty
	  pkgs.fira-code
	  pkgs.git
	  pkgs.gh
  	pkgs.linode-cli
  	pkgs.bitwarden-cli
  	pkgs.bitwarden-desktop
    pkgs.python3
    pkgs.uv
  ] ++ cyberPackages;

programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    profiles.default = {
      extensions.packages = with nur.repos.rycee.firefox-addons; [
        ublock-origin
        bitwarden
        foxyproxy-standard
      ];
    };
  };
# Configuración Git
  programs.git = {
    enable = true;
    userName = "datadiego";
    userEmail = "juandiegomariscal@gmail.com";
};



# Configuración Codium
programs.vscode = {
  enable = true;
  package = pkgs.vscodium;

  profiles.default.userSettings = {
    "workbench.colorTheme" = "Dracula Theme";
    "files.autoSave" = "afterDelay";
    "files.autoSaveDelay" = 1000;
    "editor.fontFamily" = "Fira Code";
    "editor.minimap.enabled" = false;
    "editor.tabSize" = 2;
    "editor.formatOnSave"= true;
    "workbench.sideBar.location"= "right";
  };

# Extensiones
  profiles.default.extensions = with pkgs.vscode-extensions; [
    jnoortheen.nix-ide
    ms-python.python
    ritwickdey.liveserver
    mechatroner.rainbow-csv
    tomoki1207.pdf
    dracula-theme.theme-dracula
  ];
};

# Dotfiles
  home.file = {
	  ".config/i3/config".source = dotfiles/i3;
	  ".config/alacritty/alacritty.toml".source = dotfiles/alacritty.toml;
    ".config/alacritty/themes".source = dotfiles/alacritty-themes;
	  ".bashrc".source = dotfiles/bashrc;
	  ".config/micro/colorschemes/dracula.micro".source = dotfiles/dracula.micro;
	  ".config/rofi/config.rasi".source = dotfiles/config.rasi;
    ".config/i3blocks/config".source = dotfiles/i3blocks;
    ".config/i3blocks/scripts/server-check.sh".source = scripts/server-check.sh;
    ".config/i3blocks/scripts/bateria.sh".source = scripts/bateria.sh;
    "/etc/ly/config.ini".source = dotfiles/ly;
  };

  
  # Establecer variables de entorno para modo oscuro
  home.sessionVariables = {
    GTK_THEME = "Adwaita-dark";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_STYLE_OVERRIDE = "fusion";
    MOZ_USE_XINPUT2 = "1";  # Para forzar el modo oscuro en Firefox
  };

  programs.home-manager.enable = true;
}
