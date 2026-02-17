{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./modules/core
    ./modules/networking
    ./modules/desktop
    ./modules/programs
    # ./modules/waydroid  # Vaqtincha o'chirilgan - systemd service muammosi
    ./modules/gaming
  ];
}
