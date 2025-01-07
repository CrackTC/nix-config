{ config, lib, ... }:
let
  cfg = config.editor;
in
{
  imports = [
    ./nvim
    ./helix
  ];
  options.editor = {
    enable = lib.mkEnableOption "editor";
    preferred = lib.mkOption {
      type = lib.types.str;
      default = "nvim";
      description = "User preferred editor";
    };
  };

  config = lib.mkIf cfg.enable {
    editors.${cfg.preferred}.enable = true;
  };
}
