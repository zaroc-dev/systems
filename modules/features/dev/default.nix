{ self, ... }: {
  flake.modules.nixos.dev = { pkgs, ... }: {
    imports = with self.modules.nixos; [
      docker
      js
      python
    ];

    environment.systemPackages = with pkgs; [ devenv ];
  };
}
