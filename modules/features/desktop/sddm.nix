{ inputs, ... }: {

  flake.modules.nixos.sddm = { ... }: {
    imports = [ inputs.yuki.nixosModules.yuki ];

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    programs.yuki = {
      sddm = {
        enable = true;
        # background = ./something.png;
      };
    };
  };
}
