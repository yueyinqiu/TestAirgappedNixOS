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
    (pkgs.writeShellScriptBin "t-get-nixpkgs" ''
      git clone --depth 1 -b nixos-22.05 https://github.com/NixOS/nixpkgs.git
    '')
    (pkgs.writeShellScriptBin "t-copy-nixpkgs" ''
      rsync -avzP -e "ssh -F /dev/null" /home/client/nixpkgs server@192.168.100.10:/home/server/
    '')
    (pkgs.writeShellScriptBin "t-show-derivations" ''
      nix derivation show -r path:/home/client/nixpkgs#hello > /home/client/derivation.json
    '')
    (pkgs.writeShellScriptBin "t-jq" ''
      cat /home/client/derivation.json | jq -r '.derivations | to_entries[] | select(.value.outputs.out.hash != null) | .key' > /home/client/keys.txt
    '')
    (pkgs.writeShellScriptBin "t-realise" ''
      xargs nix-store --realise $(cat /home/client/keys.txt) > outputs.txt
    '')
    (pkgs.writeShellScriptBin "t-export" ''
      nix-store --export $(cat /home/client/outputs.txt)
    '')
  ];
  services.openssh.enable = true;
  virtualisation.diskSize = 20480;
  virtualisation.vmVariant.virtualisation.mountHostNixStore = false;
  virtualisation.vmVariant.virtualisation.useBootLoader = true;

  users.users.client = {
    isNormalUser = true;
    initialPassword = "1";
    extraGroups = [ "wheel" ];
  };

  networking.interfaces.eth1.ipv4.addresses = [ {
    address = "192.168.100.11";
    prefixLength = 24;
  }];
  
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

  system.stateVersion = "26.05";
}
