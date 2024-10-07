{ config, pkgs, lib, ... }:
let cfg = config.programs.editor.zed; in {
  options.programs.editor.zed = {
    enable = lib.mkEnableOption "zed";
  };

  config = lib.mkIf (config.gui.available && cfg.enable) {
    hmConfig = {
      home.packages = [
        (pkgs.zed-editor.overrideAttrs (oldAttrs: {
          nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [
            pkgs.makeWrapper
          ];
          postInstall = ''
            wrapProgram "$out/bin/zeditor" --set DRI_PRIME 1
          '';
        }))
      ];
    };
  };
}
