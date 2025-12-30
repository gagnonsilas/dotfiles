{ pkgs, ... }:
{
  programs = {
    zsh.enable = true;
    wireshark.enable = true;

    adb.enable = true;

    sway = {
      enable = true;
    };

    light.enable = true; # Volume and brightness key

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    # alvr = {
    #   enable = true;
    #   openFirewall = true;
    # };

    mtr.enable = true;

    xfconf.enable = true;

    dconf.enable = true; # gtk fix

  };

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix!
    helix
    wget
    lxqt.lxqt-policykit
    pkgs.adwaita-icon-theme
    gsettings-desktop-schemas
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.symbols-only
    nerd-fonts.dejavu-sans-mono
    xkcd-font
    texlivePackages.atkinson
    charis-sil
  ];
}
