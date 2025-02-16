{ config, pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    # finalPackage = pkgs.rofi-wayland;

    plugins = with pkgs; [
      rofi-calc
    ];

    theme = "${pkgs.rofi}/share/rofi/themes/DarkBlue.rasi";
  };

  xdg.desktopEntries = {
    calc = {
      name = "calc";
      genericName = "Calculator";
      exec = "rofi -show calc";
      terminal = false;
      type = "Application";
    };
  };
}