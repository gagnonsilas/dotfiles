{ ... }:
{
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
        {
          domain = "@users";
          item = "rtprio";
          type = "-";
          value = 1;
        }
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
}
