{ self, inputs, ... }: {
  flake.nixosConfigurations.hiyuki = inputs.nixpkgs.lib.nixosSystem {
    imports =
      with self.nixosModules;
      [
        user
      ]
      ++ ./_hardware-configuration.nix;
  };
}
