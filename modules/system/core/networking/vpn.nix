{ self, ... }: {
  flake.nixosModules.vpn = { pkgs, ... }: {
    networking.networkmanager = {
      plugins = with pkgs; [
        networkmanager-openconnect
        networkmanager-openvpn
      ];
    };

    imports = with self.nixosModules; [
      mullvad
    ];

  };
}
