{ ... }: {
  flake.modules.nixos.nvidia = { config, lib, ... }: {
    services.xserver.videoDrivers = [ "nvidia" ];

    boot = {
      blacklistedKernelModules = [ "nouveau" ];
      initrd.kernelModules = lib.mkIf config.hardware.nvidia.enabled [
        "nvidia"
        "nvidia_modeset"
        "nvidia_drm"
      ];
    };

    hardware = {
      nvidia = {
        modesetting.enable = true;

        # for sleep / resume
        powerManagement.enable = true;

        open = false;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.latest;
      };
    };
    virtualisation.vmVariant.services.xserver.videoDrivers = lib.mkForce [ "modesetting" ];
  };
}
