{ self, ... }: {

  flake.modules.nixos.core = { ... }: {
    imports = with self.modules.nixos; [
      nix-settings
      user
      networking
      vm
      locale
      fonts
      audio
      boot
      nix-ld
    ];
  };
}
