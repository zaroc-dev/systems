{ self, ... }: {
  flake.modules.nixos.shell = { ... }: {
    imports = with self.modules.nixos; [
      zsh
      fastfetch
      nvim
      starship
    ];
  };
}
