{ inputs, ... }:
{
  flake.modules.nixos.mullvad =
    { pkgs, ... }:
    let
      pkgsUnstable = import inputs.nixpkgs-unstable {
        system = pkgs.stdenv.hostPlatform.system;
        config.allowUnfree = true;
      };
    in
    {
      services.mullvad-vpn = {
        enable = true;
        package = pkgsUnstable.mullvad;
      };

      environment.systemPackages = with pkgsUnstable; [
        mullvad-vpn
      ];
    };
}
