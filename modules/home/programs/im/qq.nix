{ config, pkgs, lib, ... }:
let
  cfg = config.programs.im.qq;
  qq-orig = pkgs.qq.override {
    commandLineArgs =
      if config.wayland.enable
      then "--ozone-platform-hint=auto --enable-wayland-ime --gtk-version=4"
      else "";
  };
  liteloaderqqnt = pkgs.fetchFromGitHub {
    owner = "LiteLoaderQQNT";
    repo = "LiteLoaderQQNT";
    rev = "1.2.3";
    hash = "sha256-R/CXxweWScfe3ktygnoXKh0XFkURG+lsFGFY7KRaHJg=";
  };
in
{
  options.programs.im.qq = {
    enable = lib.mkEnableOption "qq";
  };

  config = lib.mkIf (config.gui.available && cfg.enable) {
    hmConfig = {
      home.packages = [
        (qq-orig.overrideAttrs (oldAttrs: {
          postInstall = ''
            echo 'require(String.raw`${liteloaderqqnt}`)' > $out/opt/QQ/resources/app/app_launcher/patch.js
            sed -i $out/opt/QQ/resources/app/package.json -e 's/"main":.*/"main": "\.\/app_launcher\/patch.js",/'
            wrapProgramShell $out/bin/qq --run 'export LITELOADERQQNT_PROFILE=$HOME/.local/share/liteloaderqqnt'
          '';
        }))
      ];
    };
  };
}
