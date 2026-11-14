{ ... }: {
  flake.nixosModules.gtk = { pkgs, ... }: {

    environment.systemPackages = with pkgs; [
      tokyonight-gtk-theme
      papirus-icon-theme
    ];
    programs = {
      xfconf.enable = true;
      dconf = {
        enable = true;
        profiles.user.databases = [
          {
            lockAll = false;
            settings = {
              "org/gnome/desktop/interface" = {
                gtk-theme = "Tokyonight-Dark";
                icon-theme = "Papirus-Dark";
                color-scheme = "prefer-dark";
              };
            };
          }
        ];
      };
    };
    #  TODO integrate home-manager for styling later
  };
}
