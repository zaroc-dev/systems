{ moduleWithSystem, ... }: {
  perSystem =
    {
      pkgs,
      lib,
      system,
      ...
    }:
    {

      packages = lib.optionalAttrs (system == "x86_64-linux") {
        matlab = pkgs.callPackage ./_package.nix { };
      };
    };

  flake.modules.nixos.matlab = moduleWithSystem (
    { self', ... }: { environment.systemPackages = [ self'.packages.matlab ]; }
  );
}
