{ self, ... }: {
  flake.nixosModules.host = { ... }: {
    modules = with self.nixosModules; [
      desktop
    ];
  };
}
