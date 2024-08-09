{ config, pkgs, lib, ... }:
let
  cfg = config.programs.utility.video2gif;
  video2gif = pkgs.writeScriptBin "video2gif" ''
    #!${lib.getExe pkgs.fish}
    ${lib.getExe pkgs.ffmpeg} -i $argv[1] -vf palettegen -f apng - |
    ${lib.getExe pkgs.ffmpeg} -i $argv[1] -i - -filter_complex paletteuse $argv[2]
  '';
in
{
  options.programs.utility.video2gif = {
    enable = lib.mkEnableOption "video2gif";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = [ video2gif ];
  };
}
