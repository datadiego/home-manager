{ config, pkgs, lib, ... }:

let
  repoUrl = "https://github.com/danielmiessler/SecLists.git";
  destino = "${config.home.homeDirectory}/SecLists";
in
{
  home.packages = [ pkgs.git ];

  systemd.user.services.seclists = {
    Unit = {
      Description = "Clonar o actualizar SecLists (usuario)";
      After = [ "network-online.target" ];
    };

    Service = {
      Type = "oneshot";
      ExecStart = ''
        if [ ! -d "${destino}/.git" ]; then
          ${pkgs.git}/bin/git clone --depth 1 ${repoUrl} ${destino}
        else
          cd ${destino}
          ${pkgs.git}/bin/git pull
        fi
      '';
    };

    Install = {
      WantedBy = [ "default.target" ];  # Se ejecuta al iniciar sesión gráfica o shell
    };
  };
}
