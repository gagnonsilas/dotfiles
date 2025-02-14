{ config, pkgs, ... }:
let 
      test = pkgs.stdenv.mkDerivation {
        
      } // { installPhase = ''test''; };

      inv-query = pkgs.writeScriptBin "inv-query"  ''
          #!${pkgs.zsh}/bin/zsh

          ([[ $1 = "-r" ]] && (${pkgs.curl}/bin/curl -H "Authorization: Token 6fd451d3a0576f941c43df42b1e016be048466fd" "http://collabserver.org:10003/api/part/.*" | ${pkgs.jq}/bin/jq -r '.[] | select(.IPN != "") | .IPN + "   " + .name' > ~/.cache/fsae/inv-new.txt) && mv ~/.cache/fsae/inv-new.txt ~/.cache/fsae/inv.txt && notify-send "Inventory Updated")& 

          IPN=$(cat ~/.cache/fsae/inv.txt | rofi -dmenu -i -matching-negate-char '\0' | sed 's/ .*//')

          [[ ! -z "$IPN" ]] && firefox http://collabserver.org:10003/part/$IPN/
      '';

in {
  home.packages = [
    inv-query
  ];

  xdg.desktopEntries = {
    inv-query = {
      name = "inv-query";
      # icon = "helix";
      genericName = "Rofi Selector";
      exec = "inv-query";
      terminal = false;
      type = "Application";
    };
  }; 
}