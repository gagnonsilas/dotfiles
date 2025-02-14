# Edit this configuration file to define what should be installed on

# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot = {
    # kernelPackages = pkgs.linuxKernel.kernels.linux_6_10;
    loader.systemd-boot.enable = true; 
    loader.efi.canTouchEfiVariables = true;
  };

  
  #===== fw config settings from https://github.com/cdata/nixos-config/blob/main/hosts/framework-16-7940/default.nix ===== 

  boot = {
    # These are included on a fresh install of NixOS from media, but
    # seem to be omitted when running `nixos-generate-config` afterwards
    initrd.availableKernelModules = [ "usb_storage" "sd_mod" ];

    blacklistedKernelModules = [ "k10temp" ];
    kernelModules = [ "acpi_call" "cros_ec" "cros_ec_lpcs" "zenpower" ];
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
    extraModulePackages = with config.boot.kernelPackages;
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

  nixpkgs.config = {
    allowUnfree = true; # For things like Nvidia drivers
    nvidia.acceptLicense = true;
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = ["silas"];
  };

  systemd.services = {
    fprintd = {
      wantedBy = [ "multi-user.target" ];
      serviceConfig.type = "simple";
    };
  };

  services = {
    fprintd = {
      enable = true; 
      # tod.enable = true;
      tod.driver = pkgs.libfprint-2-tod1-goodix;
    };

    zerotierone = {
      enable = true;
      joinNetworks = [
        "83048a0632885bba"
      ];
    };

    tlp = {
      enable = false;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 60;

        #Optional helps save long term battery health
        START_CHARGE_THRESH_BAT0 = 60; # 60 and bellow it starts to charge
        STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
      };
    };

    automatic-timezoned.enable = true; 

    xserver = {
      enable = true;

      xkb = {
        layout = "us,us";
        variant = "colemak,";
        options = "grp:alt_shift_toggle,caps:ctrl_modifier";
      };

  
      displayManager = {
        lightdm.enable = false; 
      };
  
    };

    keyd = {
      enable = true;

      keyboards = {
        default = {
          ids = [ "*" ];
          settings = {
            main = {
              capslock = "overload(control, esc)";
            };
          };
        };
      };
    };
    
    dbus.enable = true;

    gvfs = {
      enable = true;
      package = lib.mkForce pkgs.gnome.gvfs;
    };

    udisks2.enable = true; 
    samba.enable = true;  
    printing.enable = true;  
    
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    udev.packages = with pkgs; [
      platformio-core.udev
    ];

    blueman.enable = true;  
    pcscd.enable = true;

    openssh = {
      enable = true;
      settings.PasswordAuthentication = true;
    };

    tumbler.enable = true;  # thumbnail something

    upower = {
      enable = true;
      percentageLow = 10;
      percentageAction = 5;
      criticalPowerAction = "HybridSleep";
    };

    logind = {
      lidSwitch = "suspend";
      powerKey = "hybrid-sleep";
    };

    # autosuspend = {
      # enable = true;
      # check
    # };

    udev = {
      enable = true;
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
    };
        # ACTION=="add|change", SUBSYSTEM=="pci", DRIVER=="pcieport", ATTR{power/wakeup}="disabled"
        # ACTION=="add|change", SUBSYSTEM=="acpi", DRIVERS=="button", ATTRS{hid}=="PNP0C0D", ATTR{power/wakeup}="disabled"

    fwupd.enable = true;
   };

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkb.options in tty.
  };
  

  virtualisation = {
    docker = {
      enable = false;
      rootless = {
        # enable = true;
        setSocketVariable = true;
        daemon.settings = {
          data-root = "/home/silas/projects/DockerRoot";
        };
      };

      daemon.settings = {
        data-root = "/home/silas/projects/DockerRoot";
      };
    };


    virtualbox.host.enable = true;
  };


  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-kde
      xdg-desktop-portal-gtk
    ];

    wlr = {
      enable = true;
      settings = {
        screencast = {
          output_name = "eDP-1";
          max_fps = 30;
          chooser_type = "simple";
          chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
        };
      };
    };
  };
  

  powerManagement = {
    enable = true; 
    powertop.enable = false;
    # scsiLinkPolicy = "min_power";
    powerDownCommands =  ''
      echo "CAN I UNSUSPEND LOCK?"
      ${pkgs.swaylock-effects}/bin/swaylock
    '';
    cpuFreqGovernor = "ondemand";
  };

  services = {
    power-profiles-daemon.enable = true; # recommended by FW team
  };


  security = {
    rtkit.enable = true;

    # pam.p11.enable = true;

    pam = {
      services.swaylock = {
        fprintAuth = true;
        text = ''
          auth sufficient pam_unix.so try_first_pass likeauth nullok
          auth sufficient pam_fprintd.so
          auth include login
        '';  
      };
      loginLimits = [
        { domain = "@users"; item = "rtprio"; type = "-"; value = 1; }
      ];
    };

    sudo = {
      enable = true; 
      extraConfig = ''
        Defaults pwfeedback
      '';
    };

    polkit.enable = true;

  };

  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;

    users.silas = {
      shell = pkgs.zsh;
      group = "wheel";
      isNormalUser = true;
      extraGroups = [ "video" "dialout" "plugdev" "docker" ];
      packages = with pkgs; [ ];
    };

    users.ubuntu = {
      shell = pkgs.zsh;
      isNormalUser = false;
      isSystemUser = true; 
      group = "users";
    };
    
    extraGroups.vboxusers.members = [ "silas" ];
  };

  programs = {
    zsh.enable = true;

    sway = {
      enable = true;
      # wrapperFeatures.gtk = true;
    };

    light.enable = true;  # Volume and brightness key

    steam = {
      enable = true; 
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    alvr = {
      enable = true;
      openFirewall = true;
    };

    mtr.enable = true;

    xfconf.enable = true;    
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    dconf.enable = true;  # gtk fix

    nix-ld = {
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
        xorg.libX11
        xorg.libXScrnSaver
        xorg.libXcomposite
        xorg.libXcursor
        xorg.libXdamage
        xorg.libXext
        xorg.libXfixes
        xorg.libXi
        xorg.libXrandr
        xorg.libXrender
        xorg.libXtst
        xorg.libxcb
        xorg.libxkbfile
        xorg.libxshmfence
        xorg.libXinerama
        xorg.libXv
        zlib
      ];
    };  
  };


  

  fonts.packages = with pkgs; [
    nerd-fonts.symbols-only
    nerd-fonts.dejavu-sans-mono
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix!
    helix
    wget
    lxqt.lxqt-policykit
  ];


  hardware = {
    graphics.enable = true;

    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  
  networking = {
    hostName = "sansa";    
    networkmanager.enable = true;

    firewall.allowedTCPPorts = [ 6081 5900 62895 11311 ];
    firewall.allowedUDPPorts = [ 6081 5900 62895 11311 ];
    firewall.enable = false;

    nameservers = [ "8.8.8.8" "8.8.4.4" ];

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

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

