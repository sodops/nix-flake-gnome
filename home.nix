{ config, pkgs, inputs, ... }:
{
  imports = [
    ./home/shell
    ./home/desktop
  ];

  home.username = "sodiq";
  home.homeDirectory = "/home/sodiq";
  programs.home-manager.enable = true;
  home.enableNixpkgsReleaseCheck = false;
  home.stateVersion = "24.11";
}
