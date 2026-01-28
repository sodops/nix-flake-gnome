{ pkgs, ... }:
{
  # Waydroid - Android konteyner tizimi
  virtualisation.waydroid.enable = true;
  virtualisation.waydroid.package = pkgs.waydroid-nftables;
  
  # Network sozlamalari
  networking.firewall.trustedInterfaces = [ "waydroid0" ];
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv4.conf.all.forwarding" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };
  
  # Foydalanuvchini waydroid guruhiga qo'shish
  users.users.sodiq.extraGroups = [ "waydroid" ];
}
