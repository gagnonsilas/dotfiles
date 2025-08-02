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

    wg-quick.interfaces = {
      serverworks = {
        privateKeyFile = "/etc/wireguard/priv-key";
        address = [ "10.0.0.4" ];
        dns = [ "10.0.0.1" ];

        peers = [
          {
            publicKey = "LDqLLPMJPuj1w2ea/JqEnDHcqeUxDqzgcu/rLAe8on4=";
            endpoint = "75.130.94.103:14438";
            persistentKeepalive = 25;
            allowedIPs = [ "10.0.0.0/24" ];
          }
        ];
      };
    };
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
