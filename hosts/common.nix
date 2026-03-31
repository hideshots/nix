{ pkgs, ... }:

{
  imports = [
    ../modules/system/fonts.nix
    ../modules/system/vpn.nix
  ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  security.sudo.wheelNeedsPassword = false;
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
  services.openssh.enable = true;

  time.timeZone = "Etc/GMT-3";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    kitty.terminfo
    neovim
    ffmpeg
    mpv
  ];
}
