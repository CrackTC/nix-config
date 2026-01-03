{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.programs.utility.aegisub;
  karaoke-helper = pkgs.fetchFromGitHub {
    owner = "CrackTC";
    repo = "aegisub-karaoke-helper";
    rev = "c00f5ed42b943e863e59b0b6e40207429b91302e";
    hash = "sha256-GTVM5K+z+O2lnpPj12tgwUVJKzjWjdZmc+DXpnCToh0=";
  };
in
{
  options.programs.utility.aegisub = {
    enable = lib.mkEnableOption "aegisub";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [
      (pkgs.aegisub.overrideAttrs (oldAttrs: {
        src = pkgs.fetchFromGitHub {
          owner = "TypesettingTools";
          repo = "aegisub";
          rev = "eef3fcc6cbf9bfd209b597258c63f8b26b8c1246";
          hash = "sha256-oEuBzgb1AKjNu1KgCb5Esb7jyBwL/31bTvOaz5k+97M=";
        };

        postPatch = ''
          patchShebangs tools/combine-config.py
        ''
        + oldAttrs.postPatch;

        postInstall = oldAttrs.postInstall + ''
          cp ${karaoke-helper}/karaoke-helper.lua $out/share/aegisub/automation/autoload/
        '';
      }))
    ];
  };
}
