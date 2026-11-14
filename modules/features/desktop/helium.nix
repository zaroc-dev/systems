{ moduleWithSystem, inputs, ... }: {

  perSystem = { inputs', ... }: {
    packages.helium = inputs'.helium.packages.default;
  };
  flake.nixosModules.helium = moduleWithSystem (
    { pkgs, inputs', ... }: {
      imports = [
        inputs.helium.nixosModules.default
      ];

      programs.helium = {
        enable = true;
        package = inputs'.helium.packages.default;

        flags = [
          "--ozone-platform-hint=auto"
          "--enable-wayland-ime"
          "--wayland-text-input-version=3"
          "--password-store=gnome-libsecret" # cant point directly to getExe libsecret :(
        ];

        policies = {
          PasswordManagerEnabled = false;
          AutofillAddressEnabled = false;
          AutofillCreditCardEnabled = false;
          MetricsReportingEnabled = false;
          SpellcheckEnabled = true;

          SpellcheckLanguage = [
            "de"
            "en-US"
          ];

          DnsOverHttpsMode = "automatic";

          ExtensionInstallForcelist = [
            "nngceckbapebfimnlniiiahkandclblb;https://clients2.google.com/service/update2/crx"
            "eimadpbcbfnmbkopoojfekhnkhdbieeh;https://google.com" # Dark Reader
          ];
        };
      };

      services.gnome.gnome-keyring.enable = true;
    }
  );
}
