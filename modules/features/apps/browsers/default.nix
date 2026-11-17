{ ... }: {

  flake.modules.nixos.browsers = { ... }: {
    imports = with self.modules.nixos; [ zen ];

    environment.systemPackages = with pkgs; [
      google-chrome # for random stuff like docs builds
    ];
  };
}
