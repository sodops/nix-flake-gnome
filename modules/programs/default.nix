{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Core
    vim git curl wget htop neofetch tree zip unzip
    gjs libxml2 aria2 gnomeExtensions.gsconnect
    obsidian super-productivity logseq
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
  virtualisation.libvirtd.enable = true;
  virtualisation.virtualbox.host.enable = false;
  programs.virt-manager.enable = true;
}
