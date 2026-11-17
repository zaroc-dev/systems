{ self, ... }: {
  flake.modules.nixos.dev = { pkgs, ... }: {
    imports = with self.modules.nixos; [
      docker
    ];

    environment.systemPackages = with pkgs; [ devenv ];
  };
}
