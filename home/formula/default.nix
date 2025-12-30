{ config, pkgs, ... }:
let 

      inv-query = pkgs.writeShellScriptBin "inv-query" (builtins.readFile ./inv-query.sh);

      ki-open = pkgs.writeScriptBin "ki-open"  ''
          #!${pkgs.zsh}/bin/zsh

          PROJECT=$(tree ~/projects -fi -L 5 | grep .kicad_pro | sed 's/\.\///' | rofi -dmenu -i -matching-negate-char '\0')

          [[ ! -z "$PROJECT" ]] && kicad $PROJECT

      '';

in {
  home.packages = [
    inv-query
    ki-open
  ];

  xdg.desktopEntries = {
    inv-query = {
      name = "inv-query";
      genericName = "Rofi Selector";
      exec = "inv-query";
      terminal = false;
      type = "Application";
    };
    ki-open = {
      name = "ki-open";
      genericName = "Rofi Selector";
      exec = "ki-open";
      terminal = false;
      type = "Application";
    };
  }; 
}