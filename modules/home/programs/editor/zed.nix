{
  config,
  pkgs,
  inputs,
  system,
  lib,
  ...
}:
let
  cfg = config.programs.editor.zed;
in
{
  options.programs.editor.zed = {
    enable = lib.mkEnableOption "zed";
  };

  config = lib.mkIf (config.gui.available && cfg.enable) {
    hmConfig = {
      home.packages = [
        inputs.nixpkgs-stable.legacyPackages.${system}.zed-editor
        pkgs.prettier
      ];
    };
  };
}
