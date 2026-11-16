{ inputs, ... }:
{
  perSystem =
    {
      pkgs,
      lib,
      ...
    }:
    {
      packages.noctalia = inputs.wrappers.wrappers.noctalia.wrap {
        inherit pkgs;

        package = pkgs.noctalia;

        settings =
          let
            assetsPath = ../../../../assets;
            baseConfig = builtins.fromTOML (builtins.readFile ./noctalia-config.toml);
          in
          lib.recursiveUpdate baseConfig {
            wallpaper = {
              default.path = "${assetsPath}/wallpapers/fractal.png";
            };
            widget.control-center = {
              custom_image = "${assetsPath}/icons/nixos.svg";
              custom_image_colorize = true;
            };
          };
      };
    };
}
