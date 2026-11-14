{ inputs, moduleWithSystem, ... }: {
  flake.nixosModules.kitty = moduleWithSystem (
    { self' }: {
      environment.systemPackages = [ self'.packages.kitty ];
    }
  );

  perSystem = { pkgs, lib, ... }: {
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
          name = "JetbransMono Nerd Font Mono";
          size = 11;
        };

        settings = {
          window_padding_width = 16;
          cursor_trail = 1;
          background_opacity = 0.9;
          scrollbar_handle_opacity = 0;
          scrollbar_track_opacity = 0;
          scrollbar_track_hover_opacity = 0;
          remember_window_size = 0;
          shell = lib.getExe pkgs.zsh; # later self'.packages.zsh
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

          foreground = "#e5e1e9";
          background = "#131318";
          selection_foreground = "#e4dff9";
          selection_background = "#474459";
          cursor = "#c6c0ff";
          cursor_text_color = "#2e295f";
          url_color = "#ebb8cf";
          active_border_color = "#c6c0ff";
          inactive_border_color = "#47464f";
          bell_border_color = "#ffb4ab";
          active_tab_foreground = "#2e295f";
          active_tab_background = "#c6c0ff";
          inactive_tab_foreground = "#c9c5d0";
          inactive_tab_background = "#201f25";
          tab_bar_background = "#0e0e13";
          mark1_foreground = "#2e295f";
          mark1_background = "#c6c0ff";
          color0 = "#3e3d45";
          color1 = "#ffb4ab";
          color2 = "#86d7a9";
          color3 = "#f5bd6f";
          color4 = "#b7c4ff";
          color5 = "#e6b6f1";
          color6 = "#80d4d7";
          color7 = "#c9c5d0";
          color8 = "#514f58";
          color9 = "#ffb4ab";
          color10 = "#86d7a9";
          color11 = "#f5bd6f";
          color12 = "#b7c4ff";
          color13 = "#e6b6f1";
          color14 = "#80d4d7";
          color15 = "#b2afba";
        };
      };
  };
}
