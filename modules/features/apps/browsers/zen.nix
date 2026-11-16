{ moduleWithSystem, inputs, ... }: {
  perSystem =
    { inputs', pkgs, ... }:
    let
      zenOverride = inputs'.zen-browser.packages.default.override {
        extraPolicies = {
          DisableTelemetry = true;
          DisablePocket = true;
          OfferToSaveLogins = false;
          PasswordManagerEnabled = false;
          DontCheckDefaultBrowser = true;

          ExtensionSettings = {
            "uBlock0@raymondhill.net" = {
              installation_mode = "force_installed";
            };
            "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
              installation_mode = "force_installed";
            };
            "addon@darkreader.org" = {
              installation_mode = "force_installed";
            };
          };
        };
      };
    in
    {
      packages.zen = inputs.wrappers.lib.wrapPackage {
        inherit pkgs;
        package = zenOverride;
        env = {
          MOZ_ENABLE_WAYLAND = "1";
        };
      };
    };

  flake.modules.nixos.zen = moduleWithSystem (
    { self', ... }:
    { pkgs, ... }:
    let
      profilesIni = pkgs.writeText "zen-profiles.ini" ''
        [General]
        StartWithLastProfile=1
        Version=2

        [Profile0]
        Name=default
        IsRelative=1
        Path=default
        Default=1
      '';
      userJs = pkgs.writeText "zen-user.js" ''
        user_pref("zen.welcome-screen.seen", true);
        user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
        user_pref("zen.view.use-single-toolbar", false);
        user_pref("zen.urlbar.behavior", "normal");
      '';
    in
    {
      environment.systemPackages = [ self'.packages.zen ];
      systemd.user.tmpfiles.rules = [
        "C+ %h/.config/zen/profiles.ini - - - - ${profilesIni}"
        "d %h/.config/zen/default/chrome 0755 - - -"
        "L+ %h/.config/zen/default/user.js - - - - ${userJs}"
        "L+ %h/.config/zen/default/chrome/userChrome.css - - - - ${./zen.css}"
      ];
    }
  );

}
