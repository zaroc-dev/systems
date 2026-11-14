{ self, ... }: {
  flake.modules.nixos.vpn = { pkgs, ... }: {
    networking.networkmanager = {
      plugins = with pkgs; [
        networkmanager-openconnect
        networkmanager-openvpn
      ];
    };

    imports = with self.modules.nixos; [
      mullvad
    ];

  };
}
