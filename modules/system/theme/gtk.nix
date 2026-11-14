{ ... }: {
  flake.modules.nixos.gtk = { pkgs, ... }: {
    programs = {
      dconf = {
        enable = true;
      };
    };
    #  TODO integrate home-manager for styling later
  };

  flake.modules.homeManager.gtk = { pkgs, config, ... }: {
    gtk = {
      enable = true;
      theme = {
        name = "Tokyonight-Dark";
        package = pkgs.tokyonight-gtk-theme;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      gtk4.theme = config.gtk.theme;

      gtk3.extraCss = ''
        @import url("file://${config.xdg.stateHome}/yuki/theme/gtk3.css");
      '';

      gtk4.extraCss = ''
        @import url("file://${config.xdg.stateHome}/yuki/theme/gtk4.css");
      '';

    };

    home.pointerCursor = {
      enable = true;
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      gtk.enable = true;
    };

    dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };
}
