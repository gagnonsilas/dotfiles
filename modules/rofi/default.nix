{ config, pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    # finalPackage = pkgs.rofi-wayland;

    plugins = with pkgs; [
      rofi-calc
    ];

    theme = /nix/store/4v4flzib9cxxg3z5mvjb8jlinihx2hbw-rofi-1.7.5/share/rofi/themes/DarkBlue.rasi;
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