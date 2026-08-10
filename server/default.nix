{ ... }:

{
  imports = [ ]; 
  services.openssh.enable = true;
  
  users.users.user = {
    isNormalUser = true;
  };

  system.stateVersion = "26.05";
}