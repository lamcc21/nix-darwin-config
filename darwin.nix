{ ... }: {
  programs.zsh.enable = true;
  services.nix-daemon.enable = true;
  system.defaults.dock.autohide = true;
  system.defaults.finder.AppleShowAllFiles = true;
}
