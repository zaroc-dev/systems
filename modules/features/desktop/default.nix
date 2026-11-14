{ self, ... }: {
  flake.modules.nixos.desktop = { ... }: {
    imports = with self.modules.nixos; [
      kitty

      niri

      sddm
      spotify
      zen
      # helium (not rly possible to do since the policies suck
    ];
  };
}
