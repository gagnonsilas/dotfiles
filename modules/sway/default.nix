{ config, lib, pkgs, ... }:

let 
  mod = "Mod4";
  terminal = "foot";
  menu = "rofi -show drun -show-icons";
in {
  home.packages = with pkgs; [
    slurp
    grim
    swww
    waybar
    foot
    autotiling-rs
    wl-clipboard
    wtype
    mako
  ];

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      screenshots = true;
      indicator-radius = 64;
      effect-blur = "7x5";
      clock = true;
    };
  };

  
  wayland.windowManager.sway = {
    enable = true;
    xwayland = true;

    extraSessionCommands = ''
      export _JAVA_AWT_WM_NONREPARENTING=1
    '';

    config = { 
      modifier = mod;
      
      terminal = "${terminal}";

      menu = "${menu}";

      fonts = { 
        names = [ "DejaVu Sans Mono" "FontAwesome 6" ];
        style = "Bold Semi-Condeensed";
        size = 11.0;
      };

      keybindings = {
        # Application bindings
        "${mod}+Shift+q" = "kill";
        "${mod}+s" = "exec ${menu}";
        "${mod}+Return" = "exec ${terminal}";
        "${mod}+Print" = "exec grim -g \"$(slurp -d)\" - | wl-copy -t image/png";

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
        "${mod}+r" = "mode resize";
        "${mod}+t" = "layout toggle tabbed split";


        # Sway
        "${mod}+Shift+c" = "restart";
        "${mod}+Shift+r" = "reload";
        "${mod}+Shift+x" = "exec i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes' 'swaymsg exit'";
        "${mod}+l" = "exec swaylock";

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

        "${mod}+w" = "[class=\"Firefox\"] focus";


        "XF86Audioraisevolume" = "exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+'";
        "XF86Audiolowervolume" =  "exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-'";
        "XF86AudioMute" = "exec 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'";
      };

      keycodebindings = {
        "233" = "exec light -A 5";
        "232" = "exec light -U 5";
      }; 

      focus = {
        newWindow = "focus";
      };

      startup = [
        { 
          command = "autotiling-rs";
          always = true;
        }
        {
          command = "nm-applet";
          always = false;
          # notification = true;
        }
        {
          command = "swww init";
          always = false;
        }
      ];

      input = {
        "*" = {
          xkb_layout = "us,us";
          xkb_variant = "colemak,";
          xkb_options = "grp:alt_shift_toggle,caps:ctrl_modifier";          
        };
        "type:touchpad" = {
          dwt = "enabled";
          tap = "enabled";
          natural_scroll = "enabled";
        };
      };
    
      gaps = {
        smartGaps = true;
        outer = 2;
        inner = 7;

      };

      window = {
         hideEdgeBorders = "smart";
         titlebar = false;
         border = 2;
      }; 

      bars = [
        {
          command = "${pkgs.waybar}/bin/waybar";
          position = "bottom";
        }
      ];

    };

    extraConfig = ''
      bindgesture swipe:4:right workspace prev
      bindgesture swipe:4:left workspace next

      bindgesture swipe:3:left exec wtype -M alt -P right -m alt
      bindgesture swipe:3:right exec wtype -M alt -P left -m alt
    '';
  };

  programs.foot = {
    enable = true;

    settings = {
      main = {
        font = "FiraMono Nerd Font Mono:style=Regular:size=8.5";
        # font = "CaskaydiaMono NF:size=7";
        # font = "JetBrainsMono NF:size=8.5";
        # font = "monospace:siez=9.5";
      };
    };
  };

  services.mako = {
    enable = true;
    font = "monospace 8";
    defaultTimeout = 10000;
    borderSize = 2;
    borderRadius = 4;
  };

}
