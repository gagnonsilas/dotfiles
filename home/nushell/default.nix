{ pkgs, ... }:

{
  programs.nushell = {
    enable = true;
    
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;
    
    shellAliases = {
      # update = "sudo nixos-rebuild switch";
      # la = "ls -a";
      # rr = "rm -r";
      #neofetch = "'neofetch | lolcat'";
      # grep = "grep --color -i";
      # vim = "echo ERROR";
      # hm = "home-manager";
      # ec = "sudoedit /etc/nixos/configuration.nix";
      # eh = "hx .config/home-manager/home.nix";
    };
  };
}
