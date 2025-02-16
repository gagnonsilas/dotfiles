{ pkgs, ... }:

{

  home.packages = with pkgs; [
    waybar-mpris
  ];

  programs.waybar = {
    enable = true;


    style = ./style.css;
    
    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        height = 20;

        modules-left = [ "sway/workspaces" "hyprland/workspaces" "sway/mode" "custom/waybar-mpris"];
        modules-center = [ "clock" ];
        modules-right = [ "group/media" "sway/language" "group/hardware" "network" "tray"];

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };

        "sway/language" = {
          "format" = "{variant}";
        };

        "group/media" = {
          "orientation" = "horizontal";
          "modules" = [
            "pulseaudio"
            "backlight"
          ];
        };

        "pulseaudio" = {
          "on-click" = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "format" = "{volume}% <big><big>{icon}</big></big>";
          "format-muted" = "{volume}% <big><big>󰖁</big></big>";
          "format-icons" = {
            "headphone" = "󰋋";
            "default" = ["󰕿" "󰖀" "󰕾"];
          };
        };


        "clock" = {
          "format" =  "{:%a, %d. %b  %H:%M}";
          "format-alt" =  "{:%m / %d / %Y  %H:%M:%S}";
        };

        "group/hardware" = {
          "orientation" = "horizontal";
          "modules" = [
            "battery"
            "cpu"
            "memory"
            "temperature"
          ];
        };

        "backlight" = {
          "format" = "{percent}% <big><big>{icon}</big></big>";
          "format-icons" = ["" "" "" "" "" "" "" "" ""];
        };

        "battery" = {
          "format" = "{capacity}% <big><big>{icon}</big></big>";
          "format-charging" = "{capacity}% <big><big>󰂄</big></big>";
          "format-icons" = {
            "default" = ["" "" "" "" ""];
          };
        };


        "tray" = {
          "spacing" = 10;
        };

        "custom/waybar-mpris" = {
          "return-type" = "json";
          "exec" = "waybar-mpris --position --autofocus --pause \"󰏤\" --order \"SYMBOL:TITLE:POSITION\"";
          "on-click" = "waybar-mpris --send toggle";
          "escape" = true;
        };
      };
    };

  };
}
