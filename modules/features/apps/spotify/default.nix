{ inputs, ... }: {

  flake.modules.nixos.spotify =
    { pkgs, ... }:
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
      wrappedSpotify = inputs.wrappers.lib.wrapPackage {
        inherit pkgs;
        package = pkgs.spotify;
        flags."--enable-features=UseOzonePlatform" = true;
        flags."--ozone-platform=wayland" = true;
      };
    in
    {
      imports = [ inputs.spicetify-nix.nixosModules.default ];

      programs.spicetify = {
        enable = true;
        spotifyPackage = wrappedSpotify;
        theme = spicePkgs.themes.catppuccin;
        colorScheme = "mocha";
        enabledExtensions = with spicePkgs.extensions; [
          hidePodcasts
          fullAppDisplay
          shuffle
        ];
      };
    };

}
