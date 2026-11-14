{ self, ... }: {
  flake.modules.nixos.networking = { ... }: {

    imports = with self.modules.nixos; [ vpn ];

    networking.networkmanager.enable = true;

    systemd.services.NetworkManager-wait-online.enable = false;
  };
}
