{ config, lib, pkgs, ... }:

with lib;

let 
  cfg = config.services.keyd;

in {
  options = {
    services.keyd = {
      enable = mkEnableOption "keyd";

      mappings = mkOption {
        type = types.attrsOf types.str;
        default = { };

        example = {
          capslock = "overload(control, esc)";
          esc = "capslock";
        };

        description = ''
          allows remapping keys 
        '';
      };
    };

    config = mkIf cfg.enable {
      systemd.user.services.keyd = {
        Unit = mkMerge [
          {
            Description = "keyd";
            After = [ "graphical-session-pre.target" ];
            PartOf = [ "graphical-session.target" ];
          }
        ];

        Service = {
          Type = "forking";
          ExecStart = "${pkgs.keyd}/bin/keyd";
          
        };
      };

      
    };

    
  };
}