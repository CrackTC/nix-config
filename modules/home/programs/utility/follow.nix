{ config, pkgs, lib, ... }:
let cfg = config.programs.utility.follow; in {
  options.programs.utility.follow = {
    enable = lib.mkEnableOption "follow";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [
      (pkgs.follow.overrideAttrs (oldAttrs: rec {
        pname = "follow";

        version = "0.1.0-beta.0";

        src = pkgs.fetchFromGitHub {
          owner = "RSSNext";
          repo = "Follow";
          rev = "v${version}";
          hash = "sha256-HMsty0ZDMqzTTPLKcfTCo1N4/LmiqoWETy7o1nB0FJw=";
        };

        pnpmDeps = pkgs.pnpm.fetchDeps {
          inherit pname version src;
          hash = "sha256-/xd57JNeKssxRytKen6uIZYhJcTi+bxbbUDtquNLALc=";
        };

        desktopItem = pkgs.makeDesktopItem {
          name = "follow";
          desktopName = "Follow";
          comment = "Next generation information browser";
          icon = "follow";
          exec = "follow --no-sandbox %U";
          categories = [ "Utility" ];
          mimeTypes = [ "x-scheme-handler/follow" ];
        };

        installPhase = ''
          runHook preInstall

          mkdir -p $out/share/{applications,follow}
          cp -r . $out/share/follow
          rm -rf $out/share/follow/{.vscode,.github}

          makeWrapper "${pkgs.electron}/bin/electron" "$out/bin/follow" \
            --inherit-argv0 \
            --add-flags $out/share/follow \
            --add-flags "--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --enable-wayland-ime"

          install -m 444 -D "${desktopItem}/share/applications/"* \
              -t $out/share/applications/

          for size in 16 24 32 48 64 128 256 512; do
            mkdir -p $out/share/icons/hicolor/"$size"x"$size"/apps
            convert -background none -resize "$size"x"$size" ${oldAttrs.icon} $out/share/icons/hicolor/"$size"x"$size"/apps/follow.png
          done

          runHook postInstall
        '';
      }))
    ];
  };
}
