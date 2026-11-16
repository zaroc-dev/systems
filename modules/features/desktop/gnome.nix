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
      environment.gnome.excludePackages = with pkgs; [
        gnome-initial-setup
      ];
      services.gnome.gnome-initial-setup.enable = false;

      programs.dconf.profiles.user.databases = [
        {
          settings = {
            "org/gnome/shell" = {
              disable-user-extensions = false;
              enabled-extensions = map (e: e.extensionUuid) extensions;
            };
            "org/gnome/shell/extensions/blur-my-shell/panel".blur = true;
            "org/gnome/shell/extensions/blur-my-shell".sigma = lib.gvariant.mkInt32 30;
            "org/gnome/desktop/background" = {
              picture-uri = "file://${self + "/assets/wallpapers/fractal.png"}";
              picture-uri-dark = "file://${self + "/assets/wallpapers/fractal.png"}";
              picture-options = "zoom";

            };
            "org/gnome/desktop/screensaver".picture-uri = "file://${
              self + "/assets/wallpapers/fractal.png"
            }";
            "org/gnome/shell/extensions/user-theme".name = "Tokyonight-Dark";
          };
        }
      ];
    };
}
