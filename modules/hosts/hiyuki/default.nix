{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations.hiyuki = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    networking.hostname = "hiyuki";

    modules =
      with self.nixosModules;
      [
        core
      ]
      ++ [ ./_hardware-configuration.nix ];
  };
}
