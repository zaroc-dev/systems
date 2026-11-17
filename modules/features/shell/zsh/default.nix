{ inputs, moduleWithSystem, ... }: {

  flake.modules.nixos.zsh = moduleWithSystem (
    { self', pkgs, ... }: {

      nixpkgs.overlays = [
        (final: prev: { zsh = self'.packages.zsh; })
      ];

      programs.zsh = {
        enable = true;
        promptInit = "";
      };

      users.defaultUserShell = self'.packages.zsh;

      environment.systemPackages = with pkgs; [ zoxide ];
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
              eza = "${lib.getExe pkgs.eza} --icons --group-directories-first";
            in
            {
              ls = eza;
              ll = "${eza} -l";
              la = "${eza} -a";
              lla = "${eza} -la";
              tree = "${eza} --tree";
              cat = lib.getExe pkgs.bat;
              vim = "nvim";

              gs = "git status";
              ga = "git add";
              gc = "git commit";
              gp = "git push";
              gl = "git log";
              gd = "git diff";
              gco = "git checkout";
              gb = "git branch";
              gcb = "git checkout -b";
              gcm = "git commit -m";
              gpl = "git pull";
              gst = "git stash";
              gsta = "git stash apply";
              gstd = "git stash drop";
              gss = "git stash show -p";

              dc = "docker compose";
              dcb = "docker compose build";
              dcu = "docker compose up";
              dcd = "docker compose down";
              dl = "docker logs -f";
              dps = "docker ps";

              nrs = "sudo nixos-rebuild switch --flake ~/systems";
              nrt = "sudo nixos-rebuild test --flake ~/systems";
              nfu = "nix flake update --flake ~/systems";
              ngc = "sudo nix-collect-garbage --delete-older-than 7d";
            };

          zshrc.content = ''

            export EDITOR=${self'.packages.nvim}
            export PATH="$HOME/.local/bin:$PATH"

            setopt AUTO_CD CORRECT
            HISTFILE=~/.zsh_history
            HISTSIZE=10000
            SAVEHIST=10000
            setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_FCNTL_LOCK

            zstyle ':completion:*' menu select
            zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
            # NixOS' /etc/zshrc already ran compinit; only needed under `nix run`
            if [[ ! -v __ETC_ZSHRC_SOURCED ]]; then
              autoload -Uz compinit && compinit
            fi

            bindkey "^[[1;5C" forward-word
            bindkey "^[[1;5D" backward-word

            export STARSHIP_CONFIG=''${STARSHIP_CONFIG:-${self'.packages.starship}/starship.toml}
            eval "$(${lib.getExe self'.packages.starship} init zsh)"
            eval "$(${lib.getExe pkgs.zoxide} init zsh --cmd cd)"
            eval "$(${lib.getExe pkgs.devenv} hook zsh)"

            source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
            # must come after all widgets and bindkeys
            source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

            ${lib.getExe pkgs.any-nix-shell} zsh | source /dev/stdin

            source ${./devenv.sh}

            if command -v fastfetch >/dev/null; then fastfetch
            else ${lib.getExe self'.packages.fastfetch}; fi
          '';
        };
      };
    };
}
