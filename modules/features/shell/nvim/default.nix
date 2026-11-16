{ moduleWithSystem, ... }: {
  flake.modules.nixos.nvim = moduleWithSystem (
    { self', ... }: {
      programs.nvim = {
        enable = true;
        package = self'.packages.nvim;
      };
      environment.variables.EDITOR = "nvim";
    }
  );

  perSystem = { inputs', ... }: {
    packages.nvim = inputs'.nvim.packages.default;
  };
}
