{ self, config, ... }: {
  flake.modules.nixos.avatar =
    { ... }:
    let
      avatar = self + /assets/icons/lilith_icon.gif;
      username = config.userConfigOptions.defaultUser.name;
    in
    {
      services.accounts-daemon.enable = true;

      system.activationScripts.userAvatar = ''
        mkdir -p /var/lib/AccountsService/icons /var/lib/AccountsService/users
        install -m 0644 ${avatar} /var/lib/AccountsService/icons/${username}
        printf '[User]\nIcon=/var/lib/AccountsService/icons/${username}\n' \
                  > /var/lib/AccountsService/users/${username}
      '';
    };
}
