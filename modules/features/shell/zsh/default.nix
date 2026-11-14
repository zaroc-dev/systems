{ inputs, moduleWithSystem, ... }: {

  flake.modules.nixos.zsh = moduleWithSystem (
    { self', pkgs, ... }: {

      nixpkgs.overlays = [
        (final: prev: { zsh = self'.packages.zsh; })
      ];

      programs.zsh = {
        enable = true;
        enableCompletion = true;
        enableBashCompletion = true;
        autosuggestions.enable = true;
        syntaxHighlighting.enable = true;
        histSize = 10000;
      };

      users.defaultUserShell = pkgs.zsh;
    }
  );

  perSystem =
    {
      pkgs,
      self',
      lib,
      ...
    }:
    {
      packages = {

        zsh = inputs.wrappers.wrappers.zsh.wrap {
          inherit pkgs;

          zshAliases =
            let
              eza = lib.getExe pkgs.eza;
            in
            {
              ls = "${eza} -l --icons";
            };

          zshrc.content = ''
            export EDITOR=nvim

            eval "$(${lib.getExe self'.packages.starship}) init zsh"
            eval "$(${lib.getExe pkgs.zoxide}) init zsh --cmd cd"

            if command - v fastfetch >/dev/null; then fastfetch
            else ${lib.getExe self'.packages.fastfetch}; fi
          '';
        };
      };
    };
}
