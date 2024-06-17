{ config, pkgs, lib, ... }:
let cfg = config.asm; in {
  options.asm = {
    enable = lib.mkEnableOption "asm devkits";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ bochs nasm dosbox mars-mips ];
  };
}
