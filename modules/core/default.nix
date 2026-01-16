{ pkgs, ... }:
{
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 2;
  boot.loader.efi.canTouchEfiVariables = true;

  # Locale & Time
  time.timeZone = "Asia/Tashkent";
  i18n.defaultLocale = "en_US.UTF-8";

  programs.zsh.enable = true;

  # User
  users.users.sodiq = {
    isNormalUser = true;
    description = "Sodiq";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" "vboxusers" ];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;

  # Optimization
  services.fstrim.enable = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };
   
  system.stateVersion = "25.11";
}
