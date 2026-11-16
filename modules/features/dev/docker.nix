{ config, ... }:
let
  username = config.userConfigOptions.defaultUser.name;
in
{
  flake.modules.nixos.docker = { pkgs, ... }: {
    virtualisation.docker = {
      enable = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };

    users.users.${username}.extraGroups = [ "docker" ];

    environment.systemPackages = with pkgs; [
      docker-buildx
      docker-compose
    ];
  };
}
