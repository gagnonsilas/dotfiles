{ config, pkgs, ... }:
{
  programs.ranger = {
    enable = true;
    mappings = {
      n = "move down=1";
      e = "move up=1";
      i = "move right=1";
    };
  };
}