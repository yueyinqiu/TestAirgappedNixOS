{ ... }:

{
  imports = [ ];
  services.openssh.enable = true;

  users.users.user = {
    isNormalUser = true;
    initialPassword = "1";
  };
  users.users.user-wheel = {
    isNormalUser = true;
    initialPassword = "1";
    extraGroups = [ "wheel" ];
  };

  system.stateVersion = "26.05";
}
