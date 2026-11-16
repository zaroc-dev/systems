{ ... }: {
  flake.modules.homeManager.zed = { pkgs, lib, ... }: {
    programs.zed-editor = {
      enable = true;

      extensions = [
        "nix"
        "toml"
        "make"
        "tokyo-night"
      ];

      userSettings = {
        assistant.enabled = false;

        theme = {
          mode = "system";
          dark = "Tokyo Night";
          light = "Toyko Night Light";
        };

        hour_format = "hour24";

        auto_update = false;

        lsp = {
          rust-analyzer = {
            binary.path = lib.getExe pkgs.rust-analyzer;
          };
          nix = {
            binary.path = lib.getExe pkgs.nil;
          };
        };

        base_keymap = "VSCode";
      };
    };
  };
}
