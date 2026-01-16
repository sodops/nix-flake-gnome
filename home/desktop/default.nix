{ pkgs, inputs, ... }:
{
  # Faqat kursor sozlamalari
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  # Paketlar ro'yxati
  home.packages = with pkgs; [
    bibata-cursors
    # GNOME Extensions
    gnomeExtensions.gsconnect
    gnomeExtensions.appindicator
    gnomeExtensions.app-name-indicator
    gnomeExtensions.auto-move-windows
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.coverflow-alt-tab
    gnomeExtensions.impatience
    gnomeExtensions.launch-new-instance
    gnomeExtensions.window-is-ready-remover

    telegram-desktop
    google-chrome
    discord
    spotify
    vscode
    postman
    obs-studio
    firefox
    inputs.antigravity-nix.packages.${pkgs.system}.default
  ];

  # GNOME Extensions sozlamalari (yoqish)
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "gsconnect@andyholmes.github.io"
        "appindicatorsupport@rgcjonas.gmail.com"
        "appnameindicator@dev64.xyz"
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
        "blur-my-shell@aunetx"
        "caffeine@patapon.info"
        "CoverflowAltTab@palatis.blogspot.com"
        "impatience@gfxmonk.net"
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
        "windowIsReady_Remover@nunofarruca@gmail.com"
      ];
    };
  };

  # GSConnect background xizmati
  systemd.user.services.gsconnect = {
    Unit = {
      Description = "GSConnect Background Service";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.gjs}/bin/gjs -m ${pkgs.gnomeExtensions.gsconnect}/share/gnome-shell/extensions/gsconnect@andyholmes.github.io/service/daemon.js";
      Restart = "always";
      RestartSec = 5;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
