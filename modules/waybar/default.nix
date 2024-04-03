{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        height = 20;

        modules-left = [ "sway/workspaces" "sway/mode" ];
        modules-center = [ "clock" ];
        modules-right = [ "group/media" "group/hardware" "network" "tray"];

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
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

        "tray" = {
          "spacing" = 10;
        };

      };
    };

  };
}
