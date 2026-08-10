{ ... }:

{
  imports = [ ]; 
  services.openssh.enable = true;
  users.users.root.initialPassword = "password";
  system.stateVersion = "26.05";
}