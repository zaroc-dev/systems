{ self, ... }: {

  flake.modules.nixos.gnome =
    { pkgs, lib, ... }:
    let
      extensions = with pkgs.gnomeExtensions; [
        blur-my-shell
        appindicator
        user-themes
      ];
    in
    {

      services.desktopManager.gnome.enable = true;

      environment.systemPackages = extensions ++ [ pkgs.tokyonight-gtk-theme ];

      services.gnome.gnome-initial-setup.enable = false;

      programs.dconf.profiles.user.databases = [
        {
          settings = {
            "org/gnome/shell" = {
              disable-user-extensions = false;
              enabled-extensions = map (e: e.extensionUuid) extensions;
            };
            "org/gnome/shell/extensions/blur-my-shell/panel".blue = true;
            "org/gnome/shell/extensions/blur-my-shell".sigma = lib.gvariant.mkInt32 30;
            "org/gnome/desktop/background" = {
              picture-uri = "file://${self + "/assets/wallpapers/cat_leaves.png"}";
              picture-uri-dark = "file://${self + "/assets/wallpapers/cat_leaves.png"}";
              picture-options = "zoom";

            };
            "org/gnome/desktop/screensaver".picture-uri = "file://${
              self + "/assets/wallpapers/cat_leaves.png"
            }";
            "org/gnome/shell/extensions/user-theme".name = "Tokyonight-Dark";
          };
        }
      ];
    };
}
