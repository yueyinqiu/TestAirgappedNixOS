{ pkgs, ... }:

{
  imports = [ ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  environment.systemPackages = [
    pkgs.git
  ];
  services.openssh.enable = true;

  users.users.user = {
    isNormalUser = true;
    initialPassword = "1";
    extraGroups = [ "wheel" ];
  };

  system.stateVersion = "26.05";
}
