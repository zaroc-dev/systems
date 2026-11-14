{ inputs, moduleWithSystem, ... }: {

  flake.modules.nixos.starship = moduleWithSystem (
    { self', ... }: {
      programs.starship = {
        enable = true;
        package = self'.packages.starship;
      };
    }
  );

  perSystem = { pkgs, ... }: {
    packages = {
      starship = inputs.wrappers.wrappers.starship.wrap {

        inherit pkgs;
        preset = [
          "nerd-font-symbols"
          "tokyo-night"
        ];

        package = pkgs.starship;
      };
    };
  };
}
