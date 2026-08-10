{ ... }:

{
  imports = [ ]; 
  services.openssh.enable = true;
  
  users.users.user = {
    isNormalUser = true;
    initialPassword = "password";
  };

  system.stateVersion = "26.05";
}