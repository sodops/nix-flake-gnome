{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./modules/core
    ./modules/networking
    ./modules/desktop
    ./modules/programs
    ./modules/waydroid
    ./modules/gaming
  ];
}
