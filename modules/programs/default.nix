{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Core
    vim git curl wget htop neofetch tree zip unzip
    gjs libxml2 aria2 gnomeExtensions.gsconnect
    gh gparted
    # DevOps
    docker-compose kubectl kubernetes-helm terraform ansible
    kdePackages.wallpaper-engine-plugin
    # Dev
    python3 nodejs
    
    # Monitoring
    prometheus grafana
    
    # Virtualization tools
    virt-viewer spice spice-gtk spice-protocol
  ];

  # Virtualization (disabled but present in config)
  virtualisation.docker.enable = true;
  virtualisation.podman.enable = true;
#  services.n8n = {
 # enable = true;
#};
  virtualisation.libvirtd = {
    enable = true;
    # Default network avtomatik yoqilsin
    allowedBridges = [ "virbr0" ];
  };
  # Libvirt default network doim aktiv bo'lishi uchun
  systemd.services.libvirtd-default-network = {
    description = "Activate libvirt default network";
    after = [ "libvirtd.service" ];
    requires = [ "libvirtd.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      ${pkgs.libvirt}/bin/virsh net-start default || true
      ${pkgs.libvirt}/bin/virsh net-autostart default || true
    '';
  };
  virtualisation.virtualbox.host.enable = false;
  programs.virt-manager.enable = true;
}
