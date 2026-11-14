{
  moduleWithSystem,
  inputs,
  ...
}:
{

  flake.nixosModules.niri = moduleWithSystem (
    { pkgs, self', ... }:
    {
      programs.niri = {
        enable = true;
        package = self'.packages.niri;
      };
    }
  );
  perSystem =
    {
      pkgs,
      unstablePkgs,
      lib,
      self',
      ...
    }:
    {
      packages = {
        niri = inputs.wrappers.wrappers.niri.wrap {
          inherit pkgs;

          package = unstablePkgs.niri;

          settings = {
            spawn-at-startup = [
              (lib.getExe pkgs.xwayland-satellite)
              (lib.getExe self'.packages.yuki)
            ];

            prefer-no-csd = { };

            binds = {
              "Mod+Return".spawn-sh = lib.getExe self'.packages.kitty;
              "Mod+Q".close-window = { };
            };

          };

          extraSettings = [
            { include = ./rules.kdl; }
            { include = ./monitor.kdl; }
            { include = ./extra_binds.kdl; }
          ];

        };

      };
    };
}
