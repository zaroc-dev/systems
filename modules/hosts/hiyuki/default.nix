{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations.hiyuki = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules =
      with self.nixosModules;
      [
        core
        desktop
        hiyuki
      ]
      ++ [ ./_hardware-configuration.nix ];
  };
}
