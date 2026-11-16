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

      environment.systemPackages = [ self'.packages.noctalia ];
    }
  );
  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    {
      packages = {
        niri = inputs.wrappers.wrappers.niri.wrap {
          inherit pkgs;

          package = pkgs.niri;

          env.XCURSOR_PATH = "${pkgs.bibata-cursors}/share/icons";
          settings = {
            spawn-at-startup = [
              (lib.getExe pkgs.xwayland-satellite)
              (lib.getExe self'.packages.noctalia)
            ];

            xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

            prefer-no-csd = { };
            cursor = {
              xcursor-theme = "Bibata-Modern-Classic";
              xcursor-size = 24;
            };

            binds = {
              "Mod+Return".spawn-sh = lib.getExe self'.packages.kitty;
              "Mod+Alt+S".spawn-sh = "noctalia msg screenshot-region";
              "Mod+Q".close-window = { };

              # noctalia binds
              "Mod+Space".spawn-sh = "noctalia msg panel-toggle launcher";
              "Mod+A".spawn-sh = "noctalia msg panel-toggle control-center";
              "Mod+Comma".spawn-sh = "noctalia msg settings-toggle";
              "Alt+Tab".spawn-sh = "noctalia msg window-switcher hold";
              "Alt+Shift+Tab".spawn-sh = "noctalia msg window-switcher hold reverse";
              "Mod+V".spawn-sh = "noctalia msg panel-toggle clipboard";
              "Mod+L".spawn-sh = "noctalia msg session lock";

              "XF86AudioRaiseVolume".spawn-sh = "noctalia msg volume-up";
              "XF86AudioLowerVolume".spawn-sh = "noctalia msg volume-down";
              "XF86AudioMute".spawn-sh = "noctalia msg volume-mute";
              "XF86MonBrightnessUp".spawn-sh = "noctalia msg brightness-up";
              "XF86MonBrightnessDown".spawn-sh = "noctalia msg brightness-down";

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
