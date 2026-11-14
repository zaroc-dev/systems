{ config, ... }: {
  hosts.miyabi.modules = with config.flake.modules.nixos; [ wsl ];
}
