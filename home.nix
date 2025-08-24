{ config, pkgs, ... }:

{
  home.username = "datadiego";
  home.homeDirectory = "/home/datadiego";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = [
	pkgs.rofi
	pkgs.alacritty
	pkgs.fira-code
	pkgs.gh
  ];

  home.file = {
	".config/i3/config".source = dotfiles/i3;
	".config/alacritty/alacritty.toml".source = dotfiles/alacritty.toml;
        ".config/alacritty/themes".source = dotfiles/alacritty-themes;
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;
}
