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

programs.ssh = {
  enable = true;
  matchBlocks = {
    "ubuntu-vm" = {
      hostname = "100.117.101.125";
      user = "sodiq";
      identityFile = "~/.ssh/id_ed25519";
    };
  };
};

  home.sessionVariables = secrets;
}
