{ config, pkgs, lib, ... }:

let
  home = config.home.homeDirectory;
  link = config.lib.file.mkOutOfStoreSymlink;
  dot = path: link "${home}/dotfiles/${path}";
in {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";

    extraPackages = with pkgs; [
      fd
      ripgrep
      jq
      poppler
      ffmpeg
      zoxide
      fzf
      imagemagick
      file
      ouch
      miller
    ];
  };

  xdg.configFile."yazi".source = dot "modules/user/yazi";
}
