{ ... }:
{
  networking = {
    networkmanager.enable = true;

    firewall.allowedTCPPorts = [
      6081
      5900
      62895
      11311
      14438
    ];
    firewall.allowedUDPPorts = [
      6081
      5900
      62895
      11311
      14438
    ];
    firewall.enable = false;

    # nameservers = [
    #   "8.8.8.8"
    #   "8.8.4.4"
    # ];

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    /*
    wireguard.interfaces = {
      serverworks = {
        privateKeyFile = "/etc/wireguard/priv-key";
        ips = [ "10.0.9.4" ];
        # dns = [ "10.0.9.1" ];

        peers = [
          {
            publicKey = "LDqLLPMJPuj1w2ea/JqEnDHcqeUxDqzgcu/rLAe8on4=";
            endpoint = "goatworks.duckdns.org:14438";
            persistentKeepalive = 25;
            allowedIPs = [ "10.0.9.0/24" ];
          }
        ];
      };
      bvr = {
        privateKeyFile = "/etc/wireguard/priv-key";
        ips = [ "10.21.9.12" ];
        # dns = [ "10.0.9.1" ];

        peers = [
          {
            publicKey = "xb7tW0EHGmK8IH5CCdAwnMcbjkMbFAnSjF1vPoP7Pm4=";
            endpoint = "goatworks.duckdns.org:43481";
            persistentKeepalive = 25;
            allowedIPs = [ "10.21.0.0/16" "10.19.0.0/16" ];
          }
        ];
      };
    };
  */
  };

  services = {
    zerotierone = {
      enable = true;
      joinNetworks = [
        "83048a0632885bba"
      ];
    };

    tailscale = {
      enable = true;
    };
  };
}
