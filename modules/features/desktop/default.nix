{ self, ... }: {
  flake.nixosModules.desktop = { ... }: {
    imports = with self.nixosModules; [
      kitty

      niri

      sddm
      helium
    ];
  };
}
