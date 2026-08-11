{ pkgs, nur, ... }:

{
  imports = [ ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  environment.systemPackages = [
    pkgs.git
    pkgs.jq
    nur.yueyinqiu.nix-fod-exporter
  ];
  services.openssh.enable = true;
  virtualisation.diskSize = 20480;
  virtualisation.writableStoreUseTmpfs = false;

  users.users.client = {
    isNormalUser = true;
    initialPassword = "1";
    extraGroups = [ "wheel" ];
  };

  networking.interfaces.eth1.ipv4.addresses = [ {
    address = "192.168.100.11";
    prefixLength = 24;
  }];

  system.stateVersion = "26.05";
}
