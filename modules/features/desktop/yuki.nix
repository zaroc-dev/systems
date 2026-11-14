{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.yuki = inputs.wrappers.lib.wrapPackage [
        inputs.yuki.wrapperModules.yuki
        {
          inherit pkgs;
          # checkout = "/home/zaroc/source/yuki";
        }
      ];
    };
}
