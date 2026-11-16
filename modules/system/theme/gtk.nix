{ ... }: {
  flake.modules.nixos.gtk = { pkgs, ... }: {
    programs = {
      dconf = {
        enable = true;
      };
    };
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
