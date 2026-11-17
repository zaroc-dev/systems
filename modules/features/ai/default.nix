{ ... }: {

  flake.modules.nixos.ai = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      t3code
      claude-code
      codex
    ];
  };
}
