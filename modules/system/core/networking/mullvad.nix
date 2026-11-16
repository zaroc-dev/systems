{ inputs, ... }:
{
  flake.modules.nixos.mullvad =
    { pkgs, ... }:
    {
      services.mullvad-vpn = {
        enable = true;
        gui.enable = true;
      };
    };
}
