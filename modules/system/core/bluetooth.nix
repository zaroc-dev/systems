{ ... }: {
  flake.modules.nixos.bluetooth = { ... }: {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General.AlwaysPairable = true;
    };
  };
}
