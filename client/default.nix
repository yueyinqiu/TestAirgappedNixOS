{ pkgs, lib, ... }:

{
  imports = [ ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  environment.systemPackages = [
    pkgs.git
    pkgs.openssh
  ];
  users.users.root.initialPassword = "password";

  # VM-only settings: second NIC (eth1) on the shared bridge so we can
  # reach other VMs. The default SLiRP NIC (eth0) is kept for convenience.
  virtualisation.vmVariant = {
    virtualisation.qemu.options = [
      "-netdev tap,id=net-tap,ifname=tap1,script=no,downscript=no"
      "-device virtio-net-pci,netdev=net-tap,mac=52:54:00:00:00:03"
    ];

    networking.interfaces.eth1 = {
      useDHCP = false;
      ipv4.addresses = [
        {
          address = "10.10.10.3";
          prefixLength = 24;
        }
      ];
    };
  };

  system.stateVersion = "26.05";
}
