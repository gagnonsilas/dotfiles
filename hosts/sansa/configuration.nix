{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking.hostName = "sansa";

  boot = {
    # kernelPackages = pkgs.linuxKernel.kernels.linux_6_10;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };
  
  systemd.services = {
    fprintd = {
      wantedBy = [ "multi-user.target" ];
      serviceConfig.type = "simple";
    };
  };

  #===== fw config settings from https://github.com/cdata/nixos-config/blob/main/hosts/framework-16-7940/default.nix =====
  services = {
    fprintd = {
      enable = true;
    };

    power-profiles-daemon.enable = true; # recommended by FW team

    
    udev = {
      enable = true;
      # ==== udev rules to configure wake from sleep ====
      # look for wakeup devices in /sys
      # find /sys -iwholename "*power/wakeup"
      # https://community.frame.work/t/framework-13-amd-sleep-s2idle-issues/54799/14
      extraRules = ''
        ACTION=="add", SUBSYSTEM=="pci", DRIVER=="pcieport", ATTR{power/wakeup}="disabled" 
        ACTION=="add", SUBSYSTEM=="pci", DRIVER=="xhci_hcd", ATTR{power/wakeup}="disabled"
        ACTION=="add", SUBSYSTEM=="pci", DRIVER=="thunderbolt", ATTR{power/wakeup}="disabled"
        ACTION=="add", SUBSYSTEM=="serio", DRIVERS=="atkbd", ATTR{power/wakeup}="disabled"
        ACTION=="add", SUBSYSTEM=="i2c", DRIVERS=="i2c_hid_acpi", ATTR{power/wakeup}="disabled"
      '';
    # ACTION=="add|change", SUBSYSTEM=="pci", DRIVER=="pcieport", ATTR{power/wakeup}="disabled"
    # ACTION=="add|change", SUBSYSTEM=="acpi", DRIVERS=="button", ATTRS{hid}=="PNP0C0D", ATTR{power/wakeup}="disabled"

    };

    fwupd.enable = true;
  };

  boot = {
    # These are included on a fresh install of NixOS from media, but
    # seem to be omitted when running `nixos-generate-config` afterwards
    initrd.availableKernelModules = [
      "usb_storage"
      "sd_mod"
    ];

    blacklistedKernelModules = [ "k10temp" ];
    kernelModules = [
      "acpi_call"
      "cros_ec"
      "cros_ec_lpcs"
      "zenpower"
    ];
    kernelParams = [
      "amd_pstate=active"
      "amdgpu.sg_display=0"
      # There seems to be an issue with panel self-refresh (PSR) that
      # causes hangs for users.
      #
      # https://community.frame.work/t/fedora-kde-becomes-suddenly-slow/58459
      # https://gitlab.freedesktop.org/drm/amd/-/issues/3647
      "amdgpu.dcdebugmask=0x10"
    ];
    extraModulePackages =
      with config.boot.kernelPackages;
      [
        acpi_call
        cpupower
        framework-laptop-kmod
        zenpower
      ]
      ++ [ pkgs.cpupower-gui ];
  };

  hardware.sensor.iio.enable = true;

  # Fixes for Mediatek wifi cards on F13/F16:. Without the following,
  # Mediatek cards have been limited to 802.11n networks & speeds:
  hardware.wirelessRegulatoryDatabase = true;
  boot.extraModprobeConfig = ''
    options cfg80211 ieee80211_regdom="US"
  '';

  #===== fw config settings end =====

  

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.#
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?
}
