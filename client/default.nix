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
    (pkgs.writeShellScriptBin "t0-get-nixpkgs" ''
      git clone --depth 1 -b nixos-22.05 https://github.com/NixOS/nixpkgs.git /home/client/nixpkgs
    '')
    (pkgs.writeShellScriptBin "t1-copy-nixpkgs" ''
      rsync -avzP -e "ssh -F /dev/null" /home/client/nixpkgs server@192.168.100.10:/home/server/
    '')
    (pkgs.writeShellScriptBin "t2-show-derivations" ''
      nix derivation show -r path:/home/client/nixpkgs#hello > /home/client/derivation.json
    '')
    (pkgs.writeShellScriptBin "t3-jq" ''
      cat /home/client/derivation.json | jq -r '.derivations | to_entries[] | select(.value.outputs.out.hash != null) | .key' > /home/client/keys.txt
    '')
    (pkgs.writeShellScriptBin "t4-realise" ''
      nix-store --realise $(cat /home/client/keys.txt) > /home/client/outputs.txt
    '')
    (pkgs.writeShellScriptBin "t5-export" ''
      nix-store --export $(cat /home/client/outputs.txt) > /home/client/fods.closure
    '')
    (pkgs.writeShellScriptBin "t6-copy-closure" ''
      rsync -avzP -e "ssh -F /dev/null" /home/client/fods.closure server@192.168.100.10:/home/server/
    '')
    (pkgs.writeShellScriptBin "t7-import" ''
      ssh -F /dev/null server@192.168.100.10 "nix-store --import < /home/server/fods.closure"
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
