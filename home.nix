{ config, pkgs, ... }:
{
  imports = [
    ./modules/sway
    ./modules/waybar
    ./modules/theme
    ./modules/nushell
    ./modules/helix
    ./modules/alacritty
    ./modules/zsh
    ./modules/firefox
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "silas";
  home.homeDirectory = "/home/silas";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # Command line apps
    git
    sshfs
    htop-vim
    neofetch
    killall
    sl
    lolcat
    eza
    tree
    man-pages
    man-pages-posix
    zip
    unzip
    globalprotect-openconnect
    gcc
    curl
    bc
    avrdude
    platformio
    cowsay
    figlet

    # Desktop
    firefox
    xfce.thunar
    xfce.thunar-volman
    dunst
    webcord
    alacritty
    feh
    gimp
    freecad
    prusa-slicer
    obsidian
    vscode
    octaveFull
    libreoffice-still
    gparted
    peek
    vlc
    inkscape
    logisim
    kicad

    # Services
    libnotify
    xdg-utils

    # Configuration
    networkmanagerapplet
    pavucontrol
    lxappearance
    glxinfo
    inxi
    acpi
    pciutils

    # Games
    jdk8
    prismlauncher

    # Windowsnn
    wineWowPackages.wayland
    protontricks
    winetricks
    bottles
    ppp
    cabextract

    # Font
    nasin-nanpa
    texliveSmall
    texlab
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };


  # Random Configs
  xdg.desktopEntries = {
    webcord = {
      name = "Webcord";
      icon = "webcord";
      genericName = "Discord";
      exec = "webcord";
      terminal = false;
      type = "Application";
    };
  };

  programs.git = {
    enable = true;
    userName = "gagnonsilas";
    userEmail = "gagnon.silas@gmail.com";
    extraConfig = {
      pull.rebase = false;
    };
  };
  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/silas/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    PS1 = " %F{blue}%~%f %F{green}>%f ";
    EDITOR = "hx";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
