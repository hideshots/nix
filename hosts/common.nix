{ pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
  services.openssh.enable = true;

  time.timeZone = "Etc/GMT-3";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  environment.systemPackages = with pkgs; [
    neovim
    curl
    wget
    git
    gh
  ];
}
