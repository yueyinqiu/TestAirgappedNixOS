{ pkgs, ... }: {
  home.packages = [
    pkgs.hello
  ];
  home.username = "server";
  home.homeDirectory = "/home/server";
  home.stateVersion = "26.05";
}
