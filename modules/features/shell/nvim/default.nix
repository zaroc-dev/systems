{ moduleWithSystem, ... }: {
  flake.modules.nixos.nvim = moduleWithSystem (
    { self', ... }: {
      environment.systemPackages = [ self'.packages.nvim ];
      environment.variables.EDITOR = "nvim";
    }
  );

  perSystem = { pkgs, ... }: {
    packages.nvim = pkgs.neovim; # later inputs'.nvim.packages.default; when nvim is wrapped
  };
}
