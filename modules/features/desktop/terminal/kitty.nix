{ inputs, moduleWithSystem, ... }: {
  flake.modules.nixos.kitty = moduleWithSystem (
    { self' }: {
      environment.systemPackages = [ self'.packages.kitty ];
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
      packages.kitty =
        let
          jetbrains-mono = pkgs.nerd-fonts.jetbrains-mono;
          fontConfig = pkgs.makeFontsConf { fontDirectories = [ jetbrains-mono ]; };
        in
        inputs.wrappers.wrappers.kitty.wrap {
          inherit pkgs;

          package = pkgs.kitty;

          environment = {
            "FONTCONFIG_FILE" = "${fontConfig}";
          };
          font = {
            name = "JetbrainsMono Nerd Font Mono";
            size = 11;
          };

          settings = {
            window_padding_width = 16;
            cursor_trail = 1;
            background_opacity = 0.8;
            background_blur = 32;
            scrollbar_handle_opacity = 0;
            scrollbar_track_opacity = 0;
            scrollbar_track_hover_opacity = 0;
            remember_window_size = 0;
            shell = lib.getExe self'.packages.zsh;
            disable_ligatures = true;
            enable_audio_bell = false;

            confirm_os_window_close = 0;
            sync_to_monitor = false;

            tab_title_template = ''
              {title} {\' :{}:\'.format(num_windows) if num_windows > 1 else \'\'}
            '';

            tab_bar_edge = "bottom";
            tab_bar_style = "powerline";
            tab_powerline_style = "slanted";

            foreground = "#c0caf5";
            background = "#1a1b26";
            selection_foreground = "#c0caf5";
            selection_background = "#283457";
            cursor = "#c0caf5";
            cursor_text_color = "#1a1b26";
            url_color = "#7dcfff";
            active_border_color = "#7aa2f7";
            inactive_border_color = "#292e42";
            bell_border_color = "#f7768e";
            active_tab_foreground = "#1a1b26";
            active_tab_background = "#7aa2f7";
            inactive_tab_foreground = "#a9b1d6";
            inactive_tab_background = "#1f2335";
            tab_bar_background = "#16161e";
            mark1_foreground = "#1a1b26";
            mark1_background = "#bb9af7";
            color0 = "#15161e";
            color1 = "#f7768e";
            color2 = "#9ece6a";
            color3 = "#e0af68";
            color4 = "#7aa2f7";
            color5 = "#bb9af7";
            color6 = "#7dcfff";
            color7 = "#a9b1d6";
            color8 = "#414868";
            color9 = "#f7768e";
            color10 = "#9ece6a";
            color11 = "#e0af68";
            color12 = "#7aa2f7";
            color13 = "#bb9af7";
            color14 = "#7dcfff";
            color15 = "#c0caf5";
          };
        };
    };
}
