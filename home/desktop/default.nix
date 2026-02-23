{ pkgs, inputs, ... }:
let
  system = "x86_64-linux";
  pixora-icon-theme = pkgs.stdenvNoCC.mkDerivation {
    pname = "pixora-icon-theme";
    version = "2026-02-23";
    src = pkgs.fetchFromGitHub {
      owner = "tsora1603";
      repo = "pixora-theme";
      rev = "main";
      hash = "sha256-UnokjC7wak/iGWDQ3c0vafo2e3QUJ+DKfbOho/D6mDs=";
    };
    installPhase = ''
      mkdir -p $out/share/icons
      cp -r * $out/share/icons/
    '';
  };
in
{
  # Faqat kursor sozlamalari
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
      icon = "utilities-terminal"; # Vaqtincha ikonka
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
    gnomeExtensions.coverflow-alt-tab
    gnomeExtensions.impatience
    gnomeExtensions.launch-new-instance
    gnomeExtensions.window-is-ready-remover
   #gnomeExtensions.screentospace
    gnomeExtensions.tiling-assistant
    gnomeExtensions.clipboard-indicator



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
    inputs.antigravity.packages.${system}.default
    temurin-bin-21
    github-copilot-cli 
    pinta
    pixora-icon-theme
   
    #Productivity
    safeeyes
    gnome-pomodoro
    blanket
    obsidian
    super-productivity
    logseq
    planner
    morgen

    # Screenshot - GNOME built-in (yengil)
    wl-clipboard  # Clipboard support
    
    # AppImage support
    appimage-run
    
    # Waydroid tools
    android-tools  # ADB for Waydroid Helper
    gnome-randr  # GNOME display configuration
    python313
    gcc
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
      ];
    };
    "org/gnome/desktop/interface" = {
      icon-theme = "Pixora";
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
