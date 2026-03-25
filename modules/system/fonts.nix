{ pkgs, inputs, ... }:

let
  appleEmoji = pkgs.stdenvNoCC.mkDerivation {
    pname = "apple-color-emoji";
    version = "2026-02-18";

    src = pkgs.fetchurl {
      url = "https://github.com/samuelngs/apple-emoji-ttf/releases/latest/download/AppleColorEmoji-Linux.ttf";
      hash = "sha256-U1oEOvBHBtJEcQWeZHRb/IDWYXraLuo0NdxWINwPUxg=";
    };

    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/share/fonts/truetype
      cp $src $out/share/fonts/truetype/AppleColorEmoji-Linux.ttf
    '';
  };
in {
  fonts = {
    packages = with pkgs; [
      inputs.apple-fonts.packages.${system}.sf-pro
      nerd-fonts.iosevka
      terminus_font
      appleEmoji
    ];

    fontconfig = {
      enable = true;
      defaultFonts.emoji = [ "Apple Color Emoji" ];

      localConf = ''
        <match target="pattern">
          <test qual="any" name="family">
            <string>Noto Color Emoji</string>
          </test>
          <edit name="family" mode="assign" binding="same">
            <string>Apple Color Emoji</string>
          </edit>
        </match>
      '';
    };
  };
}
