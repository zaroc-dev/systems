{
  inputs,
  config,
  self,
  moduleWithSystem,
  lib,
  ...
}:
let
  username = config.userConfigOptions.defaultUser.name;

  identities = {
    github = {
      hosts = [ "github.com" ];
      name = "zaroc";
      email = "arthuraktamirov@gmail.com";
    };
    gitlab = {
      hosts = [ "gitlab.com" ];
      name = "zaroc";
      email = "aktamiar@hs-albsig.de";
    };
    gitlab_nem = {
      hosts = [ "gitlab.nemetris.com" ];
      name = "Arthur Aktamirov";
      email = "arthur.aktamirov@nemetris.com";
    };
  };
  default = "github";
  pubKey = id: "${./keys + "/${id}.pub"}";
in
{
  perSystem =
    { pkgs, ... }:
    let
      identityFile =
        id: i:
        pkgs.writeText "git-identity-${id}" (
          lib.generators.toGitINI {
            user = {
              inherit (i) name email;
              signingKey = pubKey id;
            };
          }
        );
      # for `git log --show-signature`: email → public key
      allowedSigners = pkgs.writeText "allowed_signers" (
        lib.concatStrings (
          lib.mapAttrsToList (
            id: i: "${i.email} namespaces=\"git\" ${lib.fileContents (./keys + "/${id}.pub")}\n"
          ) identities
        )
      );
    in
    {
      packages.git = inputs.wrappers.wrappers.git.wrap {
        inherit pkgs;
        settings = {
          init.defaultBranch = "main";
          gpg.format = "ssh";
          gpg.ssh.allowedSignersFile = "${allowedSigners}";
          commit.gpgSign = true;
          tag.gpgSign = true;
          pull.rebase = true;

          credential =
            let
              gh = [
                ""
                "!${lib.getExe pkgs.gh} auth git-credential"
              ];
              glab = [
                ""
                "!${lib.getExe pkgs.glab} auth git-credential"
              ];
            in
            {
              "https://github.com".helper = gh;
              "https://gist.github.com".helper = gh;
              "https://gitlab.com".helper = glab;
              "https://gitlab.nemetris.com".helper = glab;
            };

          # Must be an [include]: sections are written alphabetically, and git keeps
          # the last value it reads. A plain [user] would land after the includeIfs
          # and override them.
          include.path = "${identityFile default identities.${default}}";
          includeIf = lib.listToAttrs (
            lib.concatLists (
              lib.mapAttrsToList (
                id: i:
                lib.concatMap (host: [
                  (lib.nameValuePair "hasconfig:remote.*.url:git@${host}:*/**" { path = "${identityFile id i}"; })
                  (lib.nameValuePair "hasconfig:remote.*.url:https://${host}/**" { path = "${identityFile id i}"; })
                ]) i.hosts
              ) identities
            )
          );
        };
      };
    };

  flake.modules.nixos.git = moduleWithSystem (
    { self', ... }: { config, pkgs, ... }: {

      programs.ssh.extraConfig = lib.concatStrings (
        lib.concatLists (
          lib.mapAttrsToList (
            id: i:
            map (host: ''
              Host ${host}
                User git
                IdentitiesOnly yes
                IdentityFile ${pubKey id}
            '') i.hosts
          ) identities
        )
      );
      environment.sessionVariables.SSH_AUTH_SOCK = "$HOME/.bitwarden-ssh-agent.sock";
      environment.systemPackages = [
        self'.packages.git
        pkgs.bitwarden-desktop
        pkgs.glab
        pkgs.gh
      ];

      services.gnome.gcr-ssh-agent.enable = false;
    }
  );
}
