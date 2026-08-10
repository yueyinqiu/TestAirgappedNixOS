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
  users.users.root.initialPassword = "password";
  system.stateVersion = "26.05";
}