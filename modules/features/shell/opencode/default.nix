{ inputs, moduleWithSystem, ... }: {

  flake.modules.nixos.opencode = moduleWithSystem (
    { self' }: {
      environment.systemPackages = [ self'.packages.opencode ];
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
      packages.opencode =
        let
          conf = builtins.fromJSON (builtins.readFile ./tui.json);

          theme = pkgs.writeText "opencode-lucent-tokyonight.json" (
            builtins.toJSON conf.themes."lucent-tokyonight"
          );
        in
        inputs.wrappers.lib.wrapPackage {
          inherit pkgs;
          package = pkgs.opencode;

          env.OPENCODE_CLI_CONFIG_CONTENT = builtins.toJSON conf.cli;

          runShell = [
            ''
              config_dir="''${OPENCODE_CONFIG_DIR:-''${XDG_CONFIG_HOME:-$HOME/.config}/opencode}"
              target="$config_dir/themes/lucent-tokyonight.json"

              ${pkgs.coreutils}/bin/mkdir -p "$config_dir/themes" || exit 1

              # Only replace symlinks managed by this wrapper.
              if [ -e "$target" ] || [ -L "$target" ]; then
                existing="$(${pkgs.coreutils}/bin/readlink "$target" || true)"
                case "$existing" in
                  /nix/store/*-opencode-lucent-tokyonight.json) ;;
                  *)
                    echo "Refusing to replace existing theme: $target" >&2
                    exit 1
                    ;;
                esac
              fi

              ${pkgs.coreutils}/bin/ln -sfn ${theme} "$target" || exit 1
            ''
          ];
        };
    };
}
