{ inputs, moduleWithSystem, ... }: {

  flake.modules.nixos.starship = moduleWithSystem (
    { self', ... }:
    { config, ... }:
    let
      hostname = config.networking.hostName;
      hosts = {
        hiyuki = {
          color = "purple";
          icon = "󰍹";
        };
        acheron = {
          color = "yellow";
          icon = "󰌢";
        };
        miyabi = {
          color = "cyan";
          icon = "󰖳";
        };
      };
      starship = self'.packages.starship.wrap { host = hosts.${hostname} or { }; };
    in
    {
      environment.systemPackages = [ starship ];
      environment.variables.STARSHIP_CONFIG = "${starship}/starship.toml";
    }

  );

  perSystem = { pkgs, ... }: {
    packages = {
      starship = inputs.wrappers.wrappers.starship.wrap (
        { config, lib, ... }: {
          options.host = {
            color = lib.mkOption {
              type = lib.types.str;
              default = "white";
            };
            icon = lib.mkOption {
              type = lib.types.str;
              default = "󰒋";
            };
          };
          config = {
            inherit pkgs;
            settings = lib.recursiveUpdate (builtins.fromTOML (builtins.readFile ./starship.toml)) {
              hostname.format = "[](fg:${config.host.color})[ ${config.host.icon} $hostname$ssh_symbol ](bold fg:black bg:${config.host.color})[](fg:${config.host.color}) ";
            };
            package = pkgs.starship;
          };
        }
      );
    };
  };
}
