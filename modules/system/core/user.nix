{ config, ... }:
let
  username = config.userConfigOptions.defaultUser.name;
in
{
  flake.modules.nixos.user = { ... }: {
    users.users.${username} = {
      isNormalUser = true;

      initialPassword = "password";

      extraGroups = [
        "root"
        "wheel"
      ];
    };
  };
}
