
{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    nerd-fonts.fira-mono
    nerd-fonts.victor-mono  
  ];
  programs.foot = {
    enable = true;

    settings = {
      main = {
        font = "FiraMono Nerd Font Mono:style=Regular:size=9.5";
        # font = "VictorMono Nerd Font Mono:style=Regular:size=9.5";
        # font = "CaskaydiaMono NF:size=7";
        # font = "JetBrainsMono NF:size=8.5";
        # font = "monospace:siez=9.5";
      };

      # tweak = {
      #   font-monospace-warn="no";
      # };
    };
  };
}
