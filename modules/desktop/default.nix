{ pkgs, ... }:
{
  # GNOME & XServer
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # KDE Connect / GSConnect System Service
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };
  
  services.dbus.packages = [ pkgs.gnomeExtensions.gsconnect ];
}
