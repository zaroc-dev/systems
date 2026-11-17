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
      gaming
      nvidia
      input
      dev
      apps
      ai
      windows-boot
      ./_hardware-configuration.nix
    ];
    homeModules = with flakeModules.homeManager; [
      theme
      apps
    ];
  };
}
