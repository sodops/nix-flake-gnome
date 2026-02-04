{ pkgs, ... }:
{
  # Steam configuration for gaming
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    
    # Enable Proton for Windows games compatibility
    gamescopeSession.enable = true;
  };

  # Enable 32-bit support (required for many games including Wallpaper Engine)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Additional packages for gaming and Wallpaper Engine
  environment.systemPackages = with pkgs; [
    # Proton utilities
    protontricks
    protonup-qt
    
    # Wallpaper Engine dependencies
    lz4
    mpv
    
    # Optional: GameMode for better performance
    gamemode
  ];

  # Enable GameMode service
  programs.gamemode.enable = true;
}
