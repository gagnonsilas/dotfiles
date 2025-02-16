{ pkgs, ... }:

{

  home.pointerCursor = {
    package = pkgs.simp1e-cursors;
    name = "simp1e-cursors";
    size = 24;
  };
    

  gtk = {
    enable = true;
    theme = {
      package = pkgs.gnome-themes-extra;
      name = "Adwaita-Dark";
    };

    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita-Dark";
    };

    font = {
      name = "Sans";
      size = 10;
    };
  };
}
