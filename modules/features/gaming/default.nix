{ config, ... }: {
  flake.modules.nixos.gaming =
    { pkgs, ... }:
    let
      username = config.userConfigOptions.defaultUser.name;
    in
    {
      programs.steam = {
        enable = true;
        protontricks.enable = true;
        extraCompatPackages = with pkgs; [
          dwproton-bin # gacha
          proton-ge-bin
        ];
      };

      hardware.steam-hardware.enable = true;

      users.users.${username}.extraGroups = [ "input" ];

      environment.systemPackages = with pkgs; [
        prismlauncher
      ];
    };

}
