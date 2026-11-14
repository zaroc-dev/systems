{
  moduleWithSystem,
  inputs,
  ...
}:
{

  flake.modules.nixos.niri = moduleWithSystem (
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

          env.XCURSOR_PATH = "${pkgs.bibata-cursors}/share/icons";
          settings = {
            spawn-at-startup = [
              (lib.getExe pkgs.xwayland-satellite)
              (lib.getExe self'.packages.yuki)
            ];

            prefer-no-csd = { };
            cursor = {
              xcursor-theme = "Bibata-Modern-Classic";
              xcursor-size = 24;
            };

            binds = {
              "Mod+Return".spawn-sh = lib.getExe self'.packages.kitty;
              "Mod+Q".close-window = { };
            };

            hotkey-overlay = {
              skip-at-startup = { };
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
