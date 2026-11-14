{ self, ... }: {
  flake.nixosModules.desktop = { ... }: {
    imports = with self.nixosModules; [
      kitty

      niri

      sddm

      zen
      # helium (not rly possible to do since the policies suck
    ];
  };
}
