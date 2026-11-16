{ inputs, ... }:
{
  perSystem =
    {
      pkgs,
      unstablePkgs,
      lib,
      ...
    }:
    {
      packages.noctalia = inputs.wrappers.wrappers.noctalia.wrap {
        inherit pkgs;

        package = unstablePkgs.noctalia;

        settings =
          let
            assetsPath = ../../../../assets;
            baseConfig = builtins.fromTOML (builtins.readFile ./noctalia-config.toml);
          in
          lib.recursiveUpdate baseConfig {
            wallpaper = {
              default.path = "${assetsPath}/wallpapers/cat_leaves.png";
            };
            widget.control-center = {
              custom_image = "${assetsPath}/icons/nixos.svg";
              custom_image_colorize = true;
            };
          };
      };
    };
}
