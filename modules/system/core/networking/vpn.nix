{ ... }: {
  flake.nixosModules.vpn = { pkgs, ... }: {

    networking.networkmanager = {
      plugins = with pkgs; [
        networkmanager-openconnect
        networkmanager-openvpn
      ];
    };
    programs.mullvad-vpn = {
      enable = true;
      gui.enable = true;
    };
  };
}
