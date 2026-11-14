{ inputs, config, ... }:
let
  username = config.userConfigOptions.defaultUser.name;
in
{
  flake.modules.nixos.home-manager = {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "hm-bak";
      users.${username}.home.stateVersion = "26.05";
    };
  };
}
