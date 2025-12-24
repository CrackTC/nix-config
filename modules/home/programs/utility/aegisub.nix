{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.programs.utility.aegisub;
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
          rev = "8a7d53801d2a41336f95d1db4802c97330ab9ea0";
          hash = "sha256-6hjVNM2OZKZ7hAty+jbaqEXq/OAJw+WVJeUBOVQY/II=";
        };

        postPatch = ''
          patchShebangs tools/combine-config.py
        ''
        + oldAttrs.postPatch;
      }))
    ];
  };
}
