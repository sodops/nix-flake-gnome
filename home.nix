{ config, pkgs, inputs, ... }:
let
  secretsFile = ./secrets.nix;
  secrets = if builtins.pathExists (toString secretsFile) then import secretsFile else {};
in
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

  home.sessionVariables = secrets;
}
