{
  config,
  ...
}:

let
  flakeModules = config.flake.modules;
in
{
  hosts.hiyuki = {
    modules = with flakeModules.nixos; [
      home-manager
      shell
      desktop
      theme
      core
      ./_hardware-configuration.nix
    ];
    homeModules = with flakeModules.homeManager; [ theme ];
  };
}
