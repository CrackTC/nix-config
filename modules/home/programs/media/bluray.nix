{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.programs.media.bluray;
in
{
  options.programs.media.bluray = {
    enable = lib.mkEnableOption "bluray";
  };

  config = lib.mkIf cfg.enable {
    hmConfig = {
      home.packages = [
        (pkgs.libbluray.override {
          withJava = true;
          withAACS = true;
        })
        (pkgs.makemkv.overrideAttrs rec {
          version = "1.17.7";
          srcs = [
            (pkgs.fetchurl {
              urls = [
                "http://www.makemkv.com/download/makemkv-bin-${version}.tar.gz"
                "http://www.makemkv.com/download/old/makemkv-bin-${version}.tar.gz"
              ];
              hash = "sha256-jFvIMbyVKx+HPMhFDGTjktsLJHm2JtGA8P/JZWaJUdA=";
            })
            (pkgs.fetchurl {
              urls = [
                "http://www.makemkv.com/download/makemkv-oss-${version}.tar.gz"
                "http://www.makemkv.com/download/old/makemkv-oss-${version}.tar.gz"
              ];
              hash = "sha256-di5VLUb57HWnxi3LfZfA/Z5qFRINDvb1oIDO4pHToO8=";
            })
          ];
          sourceRoot = "makemkv-oss-${version}";
          installPhase = ''
            runHook preInstall

            install -Dm555 -t $out/bin                              out/makemkv out/mmccextr out/mmgplsrv ../makemkv-bin-${version}/bin/amd64/makemkvcon
            install -D     -t $out/lib                              out/lib{driveio,makemkv,mmbd}.so.*
            install -D     -t $out/share/MakeMKV                    ../makemkv-bin-${version}/src/share/*
            install -Dm444 -t $out/share/applications               ../makemkv-oss-${version}/makemkvgui/share/makemkv.desktop
            install -Dm444 -t $out/share/icons/hicolor/16x16/apps   ../makemkv-oss-${version}/makemkvgui/share/icons/16x16/*
            install -Dm444 -t $out/share/icons/hicolor/32x32/apps   ../makemkv-oss-${version}/makemkvgui/share/icons/32x32/*
            install -Dm444 -t $out/share/icons/hicolor/64x64/apps   ../makemkv-oss-${version}/makemkvgui/share/icons/64x64/*
            install -Dm444 -t $out/share/icons/hicolor/128x128/apps ../makemkv-oss-${version}/makemkvgui/share/icons/128x128/*
            install -Dm444 -t $out/share/icons/hicolor/256x256/apps ../makemkv-oss-${version}/makemkvgui/share/icons/256x256/*

            runHook postInstall
          '';
        })
      ];
    };

    osConfig.boot.kernelModules = [ "sg" ];
  };
}
