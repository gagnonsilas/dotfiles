{ inputs, pkgs, ... }:
{

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 5d";
    };

    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [ "silas" ];
    };
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      alsa-lib
      at-spi2-atk
      at-spi2-core
      atk
      cairo
      cups
      curl
      dbus
      expat
      fontconfig
      freetype
      fuse3
      gdk-pixbuf
      glib
      glibmm
      gtk3
      icu
      libao
      libGL
      libappindicator-gtk3
      libdrm
      libglvnd
      libjpeg
      libnotify
      libpng
      libpulseaudio
      libtiff
      libunwind
      libusb1
      libuuid
      libxkbcommon
      mesa
      nspr
      nss
      openal
      openssl
      pango
      pipewire
      SDL2
      stdenv.cc.cc
      systemd
      vulkan-loader
      libX11
      libXScrnSaver
      libXcomposite
      libXcursor
      libXdamage
      libXext
      libXfixes
      libXi
      libXrandr
      libXrender
      libXtst
      libxcb
      libxkbfile
      libxshmfence
      libXinerama
      libXv
      zlib
    ];
  };

}
