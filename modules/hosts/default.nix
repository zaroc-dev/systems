{
  lib,
  config,
  inputs,
  ...
}:
let
  nixos = config.flake.modules.nixos;
  username = config.userConfigOptions.defaultUser.name;
in
{
  options.hosts = lib.mkOption {
    default = { };
    type = lib.types.attrsOf (
      lib.types.submodule {
        options.modules = lib.mkOption {
          type = lib.types.listOf lib.types.deferredModule;
          default = [ ];
        };
        options.homeModules = lib.mkOption {
          type = lib.types.listOf lib.types.deferredModule;
          default = [ ];
        };
      }
    );
  };

  config.flake.nixosConfigurations = lib.mapAttrs (
    name: host:
    inputs.nixpkgs.lib.nixosSystem {
      modules = [
        {
          networking.hostName = lib.mkDefault name;
          home-manager.users.${username}.imports = host.homeModules;
        }
      ]
      ++ host.modules;
    }
  ) config.hosts;
}
