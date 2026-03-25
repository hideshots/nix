{ pkgs, ... }:

{
  imports = [
    ../common.nix
    ../../modules/system/sddm
    ./hardware.nix
  ];

  programs.zsh.enable = true;

  networking.hostName = "lenovo";
  users.users.drama = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "25.11";
}
