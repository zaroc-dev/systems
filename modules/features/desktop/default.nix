{ self, ... }: {
  flake.modules.nixos.desktop = { pkgs, ... }: {
    imports = with self.modules.nixos; [
      avatar
      sddm
      kitty
      niri
      gnome
    ];

    services = {
      flatpak.enable = true;
      gvfs.enable = true;
    };

    systemd.services.flatpak-repo = {
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      path = [ pkgs.flatpak ];
      script = ''
        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
      '';
    };

    environment.systemPackages = with pkgs; [
      nautilus
      loupe
      papers
      file-roller
      gnome-calculator
      gnome-system-monitor
      gnome-calendar
      gnome-software
    ];
  };
}
