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
  
  # Foydalanuvchini waydroid va input guruhlariga qo'shish
  users.users.sodiq.extraGroups = [ "waydroid" "input" ];

  # Udev qoidalari: /dev/uinput uchun ruxsatlar (Keymapper ishlashi uchun)
  services.udev.extraRules = ''
    KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"
  '';
}
