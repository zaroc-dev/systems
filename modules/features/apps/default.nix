{ self, ... }: {
  flake.modules.nixos.apps = { ... }: {
    imports = with self.modules.nixos; [
      discord
      spotify
      matlab
      browsers
    ];
  };

  flake.modules.homeManager.apps = { ... }: {
    imports = with self.modules.homeManager; [ zed vscode ];
  };
}
