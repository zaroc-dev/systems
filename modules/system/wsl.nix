{ inputs, config, ... }: {
  flake.modules.nixos.wsl = {
    imports = [ inputs.nixos-wsl.nixosModules.default ];

    wsl.enable = true;
    wsl.defaultUser = config.userConfigOptions.defaultUser.name;
    nixpkgs.hostPlatform = "x86_64-linux";
  };
}
