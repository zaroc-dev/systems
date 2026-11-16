{ ... }: {
  flake.modules.nixos.windows-boot = {
    boot.loader.limine.extraEntries = ''
      /Windows
        protocol: efi
        path: guid(8ce0fc6f-50da-4b33-9734-97cdfca0a11e):/EFI/Microsoft/Boot/bootmgfw.efi
    '';
  };
}
