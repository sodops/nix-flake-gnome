{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      user.name = "Sodiq";
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
      update = "sudo nixos-rebuild switch --flake /home/sodiq/nixos-config#sodiq";
      hm-switch = "home-manager switch --flake /home/sodiq/nixos-config#sodiq";
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
    };
  };

  # Productivity Tools
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    keyMode = "vi";
    mouse = true;
    escapeTime = 0;  # ESC tugmasi kechikishini olib tashlash
    baseIndex = 1;   # Oynalarni 0 emas, 1 dan boshlash
    
    extraConfig = ''
      # Yangi oyna ochish: Ctrl+b, c
      # Oynalar o'rtasida o'tish: Ctrl+b, raqam (1,2,3...)
      # Panel bo'lish (vertikal): Ctrl+b, |
      # Panel bo'lish (gorizontal): Ctrl+b, -
      
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      
      # Panellar o'rtasida o'tish (Vi uslubida)
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      
      # Reload config: Ctrl+b, r
      bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"
    '';
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.lazygit.enable = true;
}
