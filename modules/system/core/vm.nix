{ ... }: {
  flake.nixosModules.vm =
    { ... }:
    {
      virtualisation.vmVariant = {
        virtualisation = {
          memorySize = 8096;
          cores = 8;

          qemu.options = [
            "-vga none"
            "-device virtio-gpu-gl-pci"
            "-display gtk,gl=on"
          ];
        };
      };
    };
}
