{ self, ... }: {
  flake.nixosModules.networking = { ... }: {

    imports = with self.nixosModules; [ vpn ];

    networking.networkmanager.enable = true;

    systemd.services.NetworkManager-wait-online.enable = false;
  };
}
