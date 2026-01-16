{ config, pkgs, ... }:
{
  imports = [
 	./hardware-configuration.nix
 ];

  # Bootloader sozlamalari
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 2; # Menyuni toza tutadi
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Tashkent";
  i18n.defaultLocale = "en_US.UTF-8";
 
  networking.firewall = rec {
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = allowedTCPPortRanges;
        };  
  services.dbus.packages = [ pkgs.gnomeExtensions.gsconnect ]; 
# Desktop muhiti (GNOME)
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
   };

# Virtualizatsiya va konteynerlashtirish
  virtualisation.docker.enable = false;
  virtualisation.libvirtd.enable = false;
  virtualisation.virtualbox.host.enable = false;
  virtualisation.virtualbox.host.enableExtensionPack = false;
  programs.virt-manager.enable = false;

  # Foydalanuvchi sozlamalari
  users.users.sodiq = {
    isNormalUser = true;
    description = "Sodiq";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" "vboxusers" ];
    # GUI dasturlar home-manager da boshqariladi
  };

  nixpkgs.config.allowUnfree = true;
  # Tizim CLI paketlari

  environment.systemPackages = with pkgs; [
    # Asosiy terminal utilities
    vim
    git
    curl
    wget
    htop
    neofetch
    gjs
    libxml2
    gnomeExtensions.gsconnect
    # DevOps tools
    docker-compose
    kubectl
    kubernetes-helm
    terraform
    ansible
    
    # Development environments
    python3
    nodejs
    
    # Monitoring (CLI tools)
    prometheus
    grafana
    
    # Virtualizatsiya management tools
    virt-viewer
    spice
    spice-gtk
    spice-protocol
  ];
  # SSD optimallashtirish (TRIM)

  services.fstrim.enable = true;

  # Avtomatik keraksiz fayllarni tozalash (Garbage Collection)

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Avtomatik tizim yangilanishi
#  system.autoUpgrade = {
#    enable = true;
#    allowReboot = false;  # Avtomatik restart bo'lmasin
#    dates = "weekly";
#  };   

  # Nix experimental features (ixtiyoriy)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # RAM optimizatsiya uchun zram (swap compression)
  zramSwap = {
    enable = true;
    memoryPercent = 50;  # RAM ning 50% ini compressed swap sifatida ishlatish
  };
  system.stateVersion = "25.11"; 
}
