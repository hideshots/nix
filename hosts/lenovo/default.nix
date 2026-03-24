{ ... }:

{
  imports = [
    ../common.nix
    ./hardware.nix
  ];

  networking.hostName = "lenovo";
  users.users.drama = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "25.11";
}
