{ self, inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.yuki = inputs.wrappers.lib.wrapPackage [
        inputs.yuki.wrapperModules.yuki
        {
          inherit pkgs;
          wallpaper = self + "/assets/wallpapers/cat_leaves.png";
          # checkout = "/home/zaroc/source/yuki";
        }
      ];
    };
}
