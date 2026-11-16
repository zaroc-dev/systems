{
  config,
  ...
}:

let
  flakeModules = config.flake.modules;
in
{
  hosts.acheron = {
    modules = with flakeModules.nixos; [
      home-manager
      shell
      desktop
      theme
      core
      gaming

      docker
      apps
      ./_hardware-configuration.nix
    ];
    homeModules = with flakeModules.homeManager; [
      theme
      apps
    ];
  };
}
