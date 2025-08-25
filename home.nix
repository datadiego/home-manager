{ config, pkgs, ... }:

{
  home.username = "datadiego";
  home.homeDirectory = "/home/datadiego";
  home.enableNixpkgsReleaseCheck = false;
  home.stateVersion = "24.11"; # Please read the comment before changing.

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
  ];

  programs.git = {
  enable = true;
  userName = "datadiego";
  userEmail = "juandiegomariscal@gmail.com";
};
programs.vscode.profiles.default.extensions = {
  enable = true;
  package = pkgs.vscodium;  # Asegúrate de que esté usando vscodium
  extensions = with pkgs.vscode-extensions; [
    

  ];
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
