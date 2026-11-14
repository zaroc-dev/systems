{ self, ... }: {
  flake.modules.nixos.desktop = { ... }: {
    imports = with self.modules.nixos; [
      kitty

      niri

      sddm

      zen
      # helium (not rly possible to do since the policies suck
    ];
  };
}
