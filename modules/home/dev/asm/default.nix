{ config, pkgs, lib, ... }:
let cfg = config.asm; in {
  imports = [ ./dosbox ];
  options.asm = {
    enable = lib.mkEnableOption "asm devkits";
  };

  config = lib.mkIf cfg.enable {
    dosbox.enable = true;
    hmConfig = {
      home.packages = with pkgs; [
        bochs
        nasm
        mars-mips
      ];
    };
  };
}
