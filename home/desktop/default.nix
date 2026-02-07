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
    inputs.zen-browser.packages."${system}".default
    temurin-bin-21
    
    # Screenshot - GNOME built-in (yengil)
    wl-clipboard  # Clipboard support
    
# AppImage support
    appimage-run
    
    # Waydroid tools
    android-tools  # ADB for Waydroid Helper

    # Video Wallpaper for Wayland
    mpvpaper  # Video wallpaper for Wayland
    xdotool   # Window manipulation
    wmctrl    # Window manager control
    gnome-randr  # GNOME display configuration
   
    python313
    gcc
    gnumake

    # GNOME Extensions
    gnomeExtensions.tiling-assistant
    gnomeExtensions.clipboard-indicator
  ];

  # GNOME Extensions sozlamalari (yoqish)
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      disable-extension-version-validation = true; # Versiya tekshiruvini o'chirish (Muhim!)
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
        # New Extensions
        "tiling-assistant@leleat-on-github"
        "clipboard-indicator@tudmotu.com"
        # User-installed Extensions (browser orqali)
        "screentospace@dilzhan.dev"
        "donotdisturb-button@nls1729"
      ];
    };
    
    # Screenshot keybindings - GNOME default + Gradia
    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = [ "Print" ];  # GNOME screenshot UI
    };
    
    "org/gnome/settings-daemon/plugins/media-keys" = {
      # Enable default GNOME screenshots
      screenshot = [ "<Shift>Print" ];
      window-screenshot = [ "<Alt>Print" ];
      area-screenshot = [ "<Ctrl>Print" ];
    };
  };

  # Video Wallpaper Service for GNOME
  # NOTE: Disabled - GNOME Wayland doesn't support background video layers properly
  # Use ~/nixos-config/scripts/launch-video-wallpaper.sh instead
  /*
  systemd.user.services.video-wallpaper = {
    Unit = {
      Description = "Video Wallpaper Service for GNOME";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.writeShellScript "video-wallpaper-gnome" ''
        # Wait for GNOME to fully load
        sleep 5
        
        # Get monitor name
        MONITOR=$(${pkgs.gnome-randr}/bin/gnome-randr | grep -m1 "connected" | awk '{print $1}')
        
        # Video path
        VIDEO_PATH="$HOME/.steam/steam/steamapps/workshop/content/431960/2902830928/Minecraft Soothing Scenes – Relaxing Fireplace.mp4"
        
        # Kill any existing video wallpaper
        ${pkgs.procps}/bin/pkill -f "mpv.*wallpaper-video" || true
        
        # Start mpv in fullscreen background mode
        ${pkgs.mpv}/bin/mpv \
          --loop-file=inf \
          --no-audio \
          --no-osc \
          --no-osd-bar \
          --no-input-default-bindings \
          --input-conf=/dev/null \
          --no-window-dragging \
          --fullscreen \
          --no-border \
          --ontop=no \
          --no-keepaspect-window \
          --title="wallpaper-video" \
          --x11-name="wallpaper-video" \
          --really-quiet \
          --hwdec=auto \
          "$VIDEO_PATH" &
        
        # Move window to background layer
        sleep 2
        WID=$(${pkgs.xdotool}/bin/xdotool search --name "wallpaper-video" | head -1)
        if [ -n "$WID" ]; then
          ${pkgs.xdotool}/bin/xdotool windowmove "$WID" 0 0
          ${pkgs.wmctrl}/bin/wmctrl -i -r "$WID" -b add,below,skip_taskbar,skip_pager
        fi
      ''}";
      Restart = "on-failure";
      RestartSec = 10;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
  */

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
