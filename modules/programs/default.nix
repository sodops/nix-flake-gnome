{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Core
    vim git curl wget htop neofetch
    gjs libxml2 gnomeExtensions.gsconnect
    
    # DevOps
    docker-compose kubectl kubernetes-helm terraform ansible
    
    # Dev
    python3 nodejs
    
    # Monitoring
    prometheus grafana
    
    # Virtualization tools
    virt-viewer spice spice-gtk spice-protocol
  ];

  # Virtualization (disabled but present in config)
  virtualisation.docker.enable = false;
  virtualisation.libvirtd.enable = false;
  virtualisation.virtualbox.host.enable = false;
  programs.virt-manager.enable = false;
}
