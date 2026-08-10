{ ... }: {
  home.username = "server";
  home.homeDirectory = "/home/server";
  programs.home-manager.enable = true;
  home.stateVersion = "26.05";
}
