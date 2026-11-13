{ self, ... }: {
  flake.nixModules.host = { ... }: {
    modules = with self.nixosModules; [
      user
      networking
    ];
  };
}
