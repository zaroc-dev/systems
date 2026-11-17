{ ... }: {

  flake.modules.nixos.js = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      bun
      nodejs
      pnpm
    ];
  };
}
