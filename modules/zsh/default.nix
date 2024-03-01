{ pkgs, config, ... }:

{
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    enableAutosuggestions = true;

    history = {
      ignoreDups = true;
      size = 1000;
      path = "${config.xdg.dataHome}/.zsh_history";
    };

    

    shellAliases = {
      ls = "ls --color=auto";
      grep = "grep --color -i";
      mkdir = "mkdir -p";
      update = "sudo nixos-rebuild switch";
      la = "ls -a";
      rr = "rm -r";
      #neofetch = "'neofetch | lolcat'";
      vim = "echo ERROR";
      hm = "home-manager";
      ec = "sudoedit /etc/nixos/configuration.nix";
      eh = "hx ~/.config/home-manager/";
      neofetch = "neofetch | lolcat";
    };

    envExtra = ''
      bindkey '^H' vi-backward-kill-word
      bindkey '^[[3~' delete-char
      bindkey '^[[3;5~' kill-word
      bindkey ';5C' vi-forward-word
      bindkey ';5D' vi-backward-word
      bindkey ';6C' forward-word 
      bindkey ';6D' backward-word 
    '';
      # setopt no_global_rcs

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
