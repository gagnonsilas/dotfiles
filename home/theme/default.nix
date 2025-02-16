{ pkgs, ... }:

{

  home.pointerCursor = {
    package = pkgs.simp1e-cursors;
    name = "simp1e-cursors";
    size = 24;
    gtk.enable = true;
  };
    

  gtk = {
    enable = true;

    theme = {
      name = "Nordic-darker";
      package = pkgs.nordic;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    font = {
      name = "Sans";
      size = 10;
    };
  };
}
