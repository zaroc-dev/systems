{ lib, config, ... }: {
  flake.nixosModules.vm =
    { ... }:
    let
      isVm = config.debug.vm;
    in
    {
      virtualisation.vmVariant = lib.mkIf isVm {
        virtualisation = {
          memorySize = 8096;
          cores = 8;
        };
      };
    };
}
