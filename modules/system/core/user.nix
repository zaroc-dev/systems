{ config, ... }:
let
  username = config.userConfigOptions.defaultUser.name;
in
{
  flake.nixosModules.user = { ... }: {
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
