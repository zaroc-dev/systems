{ self, ... }: {
  flake.modules.nixos.vpn = { pkgs, ... }: {
    networking.networkmanager = {
      plugins = with pkgs; [
        networkmanager-openconnect
        networkmanager-openvpn
      ];

      ensureProfiles.profiles.hs-albsig = {
        connection = {
          id = "hs-albsig";
          uuid = "bec7e85b-551c-4c65-99fb-e41a3d076cd3";
          type = "vpn";
          autoconnect = false;
        };
        vpn = {
          service-type = "org.freedesktop.NetworkManager.openconnect";
          gateway = "vpn.hs-albsig.de";
          protocol = "anyconnect";
          cookie-flags = 2;
          gateway-flags = 2;
          gwcert-flags = 2;
          resolve-flags = 2;
        };
        ipv4.method = "auto";
        ipv6.method = "auto";
      };
    };

    environment.systemPackages = [
      (pkgs.writeShellApplication {
        name = "hs-albsig-vpn";
        text = ''
          case "''${1:-connect}" in
            connect|up)
              nmcli connection up hs-albsig --ask
              ;;
            disconnect|down|close)
              nmcli connection down hs-albsig
              ;;
            *)
              echo "Usage: hs-albsig-vpn [connect|disconnect|status]" >&2
              exit 2
              ;;
          esac
        '';
      })
    ];

    imports = with self.modules.nixos; [
      mullvad
    ];
  };
}
