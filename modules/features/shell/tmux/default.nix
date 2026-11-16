{ inputs, moduleWithSystem, ... }: {
  flake.modules.nixos.tmux = moduleWithSystem (
    { self', ... }: {
      programs.tmux = {
        enable = true;
        package = self'.packages.tmux;
      };
    }
  );
  perSystem = { pkgs, ... }: {
    packages = {
      tmux = inputs.wrappers.wrappers.tmux.wrap {
        inherit pkgs;
        baseIndex = 1;
        clock24 = true;
        disableConfirmationPrompt = true;
        modeKeys = "vi";
        vimVisualKeys = true;

        allowPassthrough = true;
        sourceSensible = true;
        mouse = true;

        plugins = with pkgs.tmuxPlugins; [
          {
            plugin = tokyo-night-tmux;
            configBefore = ''
              set -g status-position bottom
              set -g @tokyo-night-tmux_show_path 1
              set -g @tokyo-night-tmux_path_format relative
              set -g @tokyo-night-tmux_show_battery_widget 0
              set -g @tokyo-night-tmux_show_netspeed 0
            '';
          }

        ];

        terminal = "tmux-256color";
        terminalOverrides = ",*:RGB";
        prefix = "C-Space";

      };
    };
  };
}
