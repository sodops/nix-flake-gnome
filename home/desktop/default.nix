{ pkgs, inputs, ... }:
{
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };
  # Custom Desktop Entries
  xdg.desktopEntries = {
    minecraft-launcher = {
      name = "Minecraft Launcher";
      genericName = "Minecraft Launcher";
      exec = "steam-run java -jar /home/sodiq/.config/launcher.jar";
      terminal = false;
      categories = [ "Game" ];
      icon = "minecraft"; 
      type = "Application";
    };
  };

  # Paketlar ro'yxati
  home.packages = with pkgs; [
    steam-run  # FHS environment for binaries like Minecraft Launcher
    bibata-cursors
    gnome-tweaks  # Super tugmasini sozlash uchun
    
    # GNOME Extensions
    gnomeExtensions.gsconnect
    gnomeExtensions.appindicator
    gnomeExtensions.app-name-indicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.impatience
    gnomeExtensions.launch-new-instance
    gnomeExtensions.window-is-ready-remover
   #gnomeExtensions.screentospace
    gnomeExtensions.tiling-assistant
    gnomeExtensions.clipboard-indicator
    # Yangi extensionlar
    gnomeExtensions.just-perfection
    gnomeExtensions.space-bar
    gnomeExtensions.user-themes



    cage
    waydroid-helper
    telegram-desktop
    google-chrome
    discord
    spotify
    vscode
    postman
    obs-studio
    firefox
    ayugram-desktop
    gemini-cli
    claude-code
    inputs.antigravity.packages.${system}.default
    temurin-bin-21
    github-copilot-cli 
    pinta
   
    #Productivity
    safeeyes
    blanket
    obsidian
    super-productivity
    morgen

    wl-clipboard  # Clipboard support
    # AppImage support
    appimage-run
    android-tools  # ADB for Waydroid Helper
    gnome-randr  # GNOME display configuration
    python313
    gcc
    distrobox
    gnumake

  ];
  # GNOME Extensions sozlamalari (yoqish)
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      disable-extension-version-validation = true; 
      enabled-extensions = [
        "gsconnect@andyholmes.github.io"
        "appindicatorsupport@rgcjonas.gmail.com"
        "appnameindicator@dev64.xyz"
        "blur-my-shell@aunetx"
        "caffeine@patapon.info"
        "CoverflowAltTab@palatis.blogspot.com"
        "impatience@gfxmonk.net"
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
        "windowIsReady_Remover@nunofarruca@gmail.com"
        "tiling-assistant@leleat-on-github"
        "clipboard-indicator@tudmotu.com"
        "screentospace@dilzhan.dev"
        # Yangi extensionlar
        "just-perfection-desktop@just-perfection"
        "space-bar@luchrioh"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
      ];
    };
  };

  # Waydroid desktop entrylarini o'chirib turuvchi service
  systemd.user.services.remove-waydroid-desktop-entries = {
    Unit = {
      Description = "Remove Waydroid desktop entries";
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "/bin/sh -c 'rm -f %h/.local/share/applications/waydroid.*.desktop %h/.local/share/applications/Waydroid.desktop'";
      RemainAfterExit = true;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
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
