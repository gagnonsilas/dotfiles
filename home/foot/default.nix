
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

      colors = {
        
          background="232136";
          foreground="e0def4";

          regular0="393552";     # black (Overlay)
          regular1="eb6f92";     # red (Love)
          regular2="9ccfd8";     # green (Foam)
          regular3="f6c177";     # yellow (Gold)
          regular4="3e8fb0";     # blue (Pine)
          regular5="c4a7e7";     # magenta (Iris)
          regular6="ea9a97";     # cyan (Rose)
          regular7="e0def4";     # white (Text)

          bright0="5c5776";      # bright black (lighter Overlay)
          bright1="ff98ba";      # bright red (lighter Love)
          bright2="c5f9ff";      # bright green (lighter Foam)
          bright3="ffeb9e";      # bright yellow (lighter Gold)
          bright4="6ab7d9";      # bright blue (lighter Pine)
          bright5="eed0ff";      # bright magenta (lighter Iris)
          bright6="ffc3bf";      # bright cyan (lighter Rose)
          bright7="fefcff";      # bright white (lighter Text)

          flash="f6c177";        # yellow (Gold)

          # cursor="232136";
      };

      # tweak = {
      #   font-monospace-warn="no";
      # };
    };
  };
}
