{ pkgs, ... }:

{
  imports = [ ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  
  services.openssh.enable = true;

  virtualisation.diskSize = 20480;
  virtualisation.vmVariant.virtualisation.mountHostNixStore = false;
  virtualisation.vmVariant.virtualisation.useBootLoader = true;

  systemd.services.expand-vda1 = {
    description = "Auto expand vda1 partition and filesystem";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      ${pkgs.cloud-utils}/bin/growpart /dev/vda 1 || true
      ${pkgs.e2fsprogs}/bin/resize2fs /dev/vda1
    '';
  };

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
