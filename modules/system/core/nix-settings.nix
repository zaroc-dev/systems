{ inputs, ... }: {

  flake.modules.nixos.nix-settings = { ... }: {

    system.stateVersion = "26.05";

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    nixpkgs.config.allowUnfree = true;

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
      randomizedDelaySec = "30min";
    };
  };

  perSystem = { system, ... }: {
    _module.args = {
      unstablePkgs = import inputs.nixpkgs-unstable { inherit system; };
    };
  };
}
