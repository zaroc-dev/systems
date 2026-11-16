{ ... }: {
  flake.modules.nixos.input = { ... }: {
    hardware = {
      wooting.enable = true;
      opentabletdriver.enable = true;
      uinput.enable = true;
    };

    boot = {
      kernelModules = [ "uinput" ];
      blacklistedKernelModules = [ "wacom" ];
    };
  };
}
