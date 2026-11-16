{ self, ... }: {
  flake.modules.nixos.apps = { ... }: {
    imports = with self.modules.nixos; [
      discord
      spotify

      matlab
      zen
    ];
  };

  flake.modules.homeManager.apps = { ... }: {
    imports = with self.modules.homeManager; [ zed ];
  };
}
