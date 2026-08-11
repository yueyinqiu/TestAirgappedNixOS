{ ... }:

{
  imports = [ ];
  services.openssh.enable = true;

  virtualisation.diskSize = 20480;
  virtualisation.vmVariant.virtualisation.mountHostNixStore = false;
  virtualisation.vmVariant.virtualisation.useBootLoader = true;

  users.users.server = {
    isNormalUser = true;
    initialPassword = "1";
  };
  users.users.server-wheel = {
    isNormalUser = true;
    initialPassword = "1";
    extraGroups = [ "wheel" ];
  };

  networking.interfaces.eth1.ipv4.addresses = [ {
    address = "192.168.100.10";
    prefixLength = 24;
  }];

  system.stateVersion = "26.05";
}
