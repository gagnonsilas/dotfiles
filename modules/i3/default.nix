{ config, lib, pkgs, ... }:

let 
  mod = "Mod4";
  terminal = "alacritty";
  menu = "rofi -show drun -show-icons";
in {
  home.packages = with pkgs; [
    i3lock
    rofi
    flameshot
    nitrogen
    i3-auto-layout
  ];

  programs.i3status-rust = {
    enable = true;
    bars = {
      main = {
        blocks = [
          { block = "cpu"; }
          {
            block = "memory";
            format = " $icon $mem_total_used_percents.eng(w:2) ";
            format_alt = " $icon_swap $swap_used_percents.eng(w:2) ";
          }
          {
            block = "sound";
            click = [{
              button = "left";
              cmd = "pavucontrol";
            }];
          }
          {
            block = "time";
            interval = 5;
            format = " $timestamp.datetime(f:'%a %d/%m %R') ";
          }
        ];

        
      };
    };
  };


  xsession.windowManager.i3 = {
    enable = true;
    config = { 
      modifier = mod;
      
      terminal = "${terminal}";

      menu = "rofi -show drun -show-icons";

      fonts = { 
        names = [ "DejaVu Sans Mono" "FontAwesome 6" ];
        style = "Bold Semi-Condeensed";
        size = 11.0;
      };

      keybindings = {

        "${mod}+l" = "exec firefox 'linkedin.com'";
        # Application bindings
        "${mod}+Shift+q" = "kill";
        "${mod}+s" = "exec ${menu}";
        "${mod}+Return" = "exec ${terminal}";
        "${mod}+Print" = "exec flameshot gui";

        # Focus
        "${mod}+h" = "focus left";
        "${mod}+n" = "focus down";
        "${mod}+e" = "focus up";
        "${mod}+i" = "focus right";
        "${mod}+a" = "focus parent";

        # Move
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+n" = "move down";
        "${mod}+Shift+e" = "move up";
        "${mod}+Shift+i" = "move right";
        "${mod}+f" = "fullscreen toggle";
        "${mod}+Shift+space" = "floating toggle";

        # Workspaces
        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";
        "${mod}+9" = "workspace number 9";

        "${mod}+Shift+1" = "move container to workspace number 1; workspace number 1";
        "${mod}+Shift+2" = "move container to workspace number 2; workspace number 2";
        "${mod}+Shift+3" = "move container to workspace number 3; workspace number 3";
        "${mod}+Shift+4" = "move container to workspace number 4; workspace number 4";
        "${mod}+Shift+5" = "move container to workspace number 5; workspace number 5";
        "${mod}+Shift+6" = "move container to workspace number 6; workspace number 6";
        "${mod}+Shift+7" = "move container to workspace number 7; workspace number 7";
        "${mod}+Shift+8" = "move container to workspace number 8; workspace number 8";
        "${mod}+Shift+9" = "move container to workspace number 9; workspace number 9";

        "${mod}+Shift+c" = "reload";
        "${mod}+Shift+r" = "restart";
        "${mod}+Shift+x" = "exec i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes' 'i3-msg exit'";

        "${mod}+r" = "mode resize";
      };

      keycodebindings = {
        "233" = "exec light -A 5";
        "232" = "exec light -U 5";
      }; 

      startup = [
        { 
          command = "nitrogen --restore";
          always = false;
          notification = false;
        }
        { 
          command = "i3-auto-layout";
          always = true;
          notification = false;
        }
        {
          command = "nm-applet";
          always = false;
          notification = true;
        }
      ];
    
      gaps = {
        smartGaps = true;
        outer = 2;
        inner = 7;

      };

      window = {
         hideEdgeBorders = "both";
         titlebar = false;
         border = 2;
      }; 

      bars = [
        {
          position = "bottom";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ";
        }
      ];
    };
  };
}
