{ self, config, ... }: {

  flake.modules.nixos.boot =
    { pkgs, ... }:
    let
      username = config.userConfigOptions.defaultUser.name;
    in
    {
      boot = {
        kernelPackages = pkgs.linuxPackages_latest;

        kernelParams = [
          "quiet"
          "splash"
          "udev.log_level=3"
        ];

        consoleLogLevel = 0;
        loader = {
          systemd-boot.enable = false;
          limine = {
            enable = true;
            efiSupport = true;
            enableEditor = false;

            secureBoot.enable = false;

            style = {
              wallpapers = [ (self + "/assets/wallpapers/fractal.png") ];
              wallpaperStyle = "stretched";
              interface.branding = "${username} OS";
            };
          };
        };

      };
      environment.systemPackages = with pkgs; [
        efibootmgr
        sbctl
      ];
    };
}
