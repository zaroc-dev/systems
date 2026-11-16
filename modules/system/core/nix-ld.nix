{ moduleWithSystem, ... }: {
  flake.modules.nixos.nix-ld = moduleWithSystem (
    { pkgs, ... }: {
      programs.nix-ld = {
        enable = true;
        libraries = with pkgs; [
          stdenv.cc.cc
          util-linux
          zlib
          libusb1
        ];
      };
    }
  );
}
