{ config, lib, ... }:
let cfg = config.terminal; in {
  imports = [ ./kitty.nix ];
  options.terminal = {
    enable = lib.mkEnableOption "terminal emulator";
    preferred = lib.mkOption {
      type = lib.types.str;
      default = "kitty";
      description = "User preferred terminal emulator";
    };
  };

  config = lib.mkIf (config.gui.available && cfg.enable) {
    terminals.${cfg.preferred}.enable = true;
  };
}
