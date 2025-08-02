{ config, pkgs, ... }:
let 
# use http://inventree.com/api/user/token/ to get token
      inv-query = pkgs.writeScriptBin "inv-query"  ''
          #!${pkgs.zsh}/bin/zsh

          ([[ $1 = "-r" ]] && (${pkgs.curl}/bin/curl -H "Authorization: Token inv-dc257db44013fbf5d205b0fa3138e607360816eb-20250721" "http://inventree.tortoise-chickadee.ts.net/api/part/" | ${pkgs.jq}/bin/jq -r '.[] | select(.IPN != "") | .IPN + "   " + .name + "   " + .description' > ~/.cache/agzen/inv-new.txt) && mv ~/.cache/agzen/inv-new.txt ~/.cache/agzen/inv.txt && notify-send "Inventory Updated")& 

          IPN=$(cat ~/.cache/agzen/inv.txt | rofi -dmenu -i -matching-negate-char '\0' | sed 's/ .*//')
          
          [[ ! -z "$IPN" ]] && firefox http://inventree.tortoise-chickadee.ts.net/part/$IPN/
      '';

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