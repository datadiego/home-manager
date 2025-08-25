{ config, pkgs, ... }:

{
  home.username = "datadiego";
  home.homeDirectory = "/home/datadiego";
  home.enableNixpkgsReleaseCheck = false;
  home.stateVersion = "24.11"; 

  home.packages = [
	pkgs.vscodium
	pkgs.rofi
	pkgs.alacritty
	pkgs.fira-code
	pkgs.git
	pkgs.gh
	pkgs.micro
	pkgs.xclip
	pkgs.feh
  pkgs.linode-cli
  pkgs.bitwarden-cli
  pkgs.bitwarden-desktop
  ];

  programs.git = {
  enable = true;
  userName = "datadiego";
  userEmail = "juandiegomariscal@gmail.com";
};
programs.vscode = {
  enable = true;
  package = pkgs.vscodium;  # Asegúrate de que esté usando vscodium
  profiles.default.extensions = with pkgs.vscode-extensions; [
    jnoortheen.nix-ide
    ms-python.python
    ritwickdey.liveserver
    mechatroner.rainbow-csv
    tomoki1207.pdf
    dracula-theme.theme-dracula
  ];

  profiles.default.userSettings = {
    "workbench.colorTheme" = "Dracula Theme";
    "files.autoSave" = "afterDelay";
    "files.autoSaveDelay" = 1000;
    "editor.fontFamily" = "Fira Code";
  };
};

  home.file = {
	".config/i3/config".source = dotfiles/i3;
	".config/alacritty/alacritty.toml".source = dotfiles/alacritty.toml;
  ".config/alacritty/themes".source = dotfiles/alacritty-themes;
	".bashrc".source = dotfiles/bashrc;
	".config/micro/colorschemes/dracula.micro".source = dotfiles/dracula.micro;
	".config/rofi/config.rasi".source = dotfiles/config.rasi;
  ".config/i3blocks/config".source = dotfiles/i3blocks;
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;
}
