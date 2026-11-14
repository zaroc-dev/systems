{
  description = "ZAROC systems";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    wrappers.url = "github:nix-community/nix-wrapper-modules";

    yuki.url = "github:zaroc-dev/yuki";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    # helium = {
    #  url = "github:oxcl/nix-flake-helium-browser";
    #  inputs.nixpkgs.follows = "nixpkgs-unstable";
    #};

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
