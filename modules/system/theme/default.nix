{ self, ... }: {
  flake.modules.nixos.theme = { ... }: {
    imports = with self.modules.nixos; [ gtk ];
  };

  flake.modules.homeManager.theme = { ... }: {
    imports = with self.modules.homeManager; [ gtk ];
  };
}
