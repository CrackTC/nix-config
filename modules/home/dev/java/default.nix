{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.java;
in
{
  imports = [ ./idea.nix ];

  options.java = {
    enable = lib.mkEnableOption "java";
  };

  config = lib.mkIf cfg.enable {
    idea.enable = true;
    hmConfig = {
      home.packages = with pkgs; [
        (jdk21.override { enableJavaFX = true; })
      ];
    };
  };
}
