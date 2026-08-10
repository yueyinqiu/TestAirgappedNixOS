{ lib, ... }:

{
  imports = [ ];
  services.openssh.enable = true;

  # VM-only settings: second NIC (eth1) on the shared bridge so other
  # VMs can reach us. The default SLiRP NIC (eth0) is kept for convenience.
  virtualisation.vmVariant = {
    virtualisation.qemu.options = [
      "-netdev tap,id=net-tap,ifname=tap0,script=no,downscript=no"
      "-device virtio-net-pci,netdev=net-tap,mac=52:54:00:00:00:02"
    ];

    networking.interfaces.eth1 = {
      useDHCP = false;
      ipv4.addresses = [
        {
          address = "10.10.10.2";
          prefixLength = 24;
        }
      ];
    };
  };

  users.users.user = {
    isNormalUser = true;
    initialPassword = "password";
  };

  system.stateVersion = "26.05";
}
