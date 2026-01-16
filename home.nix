{ config, pkgs, ... }:
{
  home.username = "sodiq";
  home.homeDirectory = "/home/sodiq";
  programs.home-manager.enable = true;
  programs.git.enable = true;
  
  # Faqat kursor sozlamalari (Tema default bo'ladi)
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  # Paketlar ro'yxati
  home.packages = with pkgs; [
    # Cursor (faqat bu kerak)
    bibata-cursors
    
    # GUI dasturlar
    telegram-desktop
    google-chrome
    discord
    spotify
    vscode
    postman
    obs-studio
    firefox
  ];

  # GSConnect background xizmati
  systemd.user.services.gsconnect = {
    Unit = {
      Description = "GSConnect Background Service";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      # Nix store ichidagi gjs va daemon.js ga to'g'ridan-to'g'ri yo'l ko'rsatamiz
      ExecStart = "${pkgs.gjs}/bin/gjs -m ${pkgs.gnomeExtensions.gsconnect}/share/gnome-shell/extensions/gsconnect@andyholmes.github.io/service/daemon.js";
      Restart = "always";
      RestartSec = 5;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  home.stateVersion = "24.11";
}
