{ self, ... }: {

  flake.nixosModules.core = { ... }: {
    imports = with self.nixosModules; [
      nix-settings
      user
      networking

      vm
    ];
  };
}
