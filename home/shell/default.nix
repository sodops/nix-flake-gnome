{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      user.name = "Sodiq"; # Git username qo'shib qo'ydim
      user.email = "sodiq@localhost";
    };
  };

  # Zsh configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch --flake .";
      hm-switch = "home-manager switch --flake .";
      clean = "nix-collect-garbage -d";
    };

    history = {
      size = 10000;
      path = "$HOME/.zsh_history";
    };
  };

  # Starship prompt
  programs.starship = {
    enable = true;
    
    settings = {
      add_newline = false;
      message = {
         disabled = true;
      };
    };
  };
}
