{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    zoxide
  ];
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;

    history = {
      ignoreDups = true;
      size = 10000;
      path = "${config.xdg.dataHome}/.zsh_history";
      share = false;
    };

    

    shellAliases = {
    };

    envExtra = ''
      bindkey '^H' vi-backward-kill-word
      bindkey '^[[3~' delete-char
      bindkey '^[[3;5~' kill-word
      bindkey ';5C' vi-forward-word
      bindkey ';5D' vi-backward-word
      bindkey ';6C' forward-word 
      bindkey ';6D' backward-word 
      autoload -Uz compinit
      compinit -i
      eval "$(zoxide init --cmd cd zsh)"
      setopt no_global_rcs
      export PS1=" %F{blue}%~%f %F{green}>%f "
      [[ -v name ]] && export PS1=" %F{magenta}($name)%f$PS1"
    '';

      # source /home/silas/.nix-profile/etc/profile.d/hm-session-vars.sh
      # PS1="test"
    # ZSH better VI mode 
    # initExtra = ''
    #     source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    # '';

    # zplug = {
    #   enable = true;
    #   plugins = [
    #     { name = "zsh-users/zsh-autosuggestions"; }
    #   ];
    # };
      
  };
}


                  
