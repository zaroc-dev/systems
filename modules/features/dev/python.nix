{ ... }: {
  flake.modules.nixos.python =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.uv
        pkgs.ruff
        pkgs.python315
      ];
    };
}
