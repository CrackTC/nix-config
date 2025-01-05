{ config, lib, ... }:
let cfg = config.terminal; in {
  imports = [
    ./kitty.nix
    ./ghostty.nix
  ];

  options.terminal = {
    enable = lib.mkEnableOption "terminal emulator";
    preferred = lib.mkOption {
      type = lib.types.str;
      default = "kitty";
      description = "User preferred terminal emulator";
    };
    preferredPackage = lib.mkOption {
      type = lib.types.package;
      default = config.terminals.${cfg.preferred}.package;
      description = "User preferred terminal emulator package";
    };
  };

  config = lib.mkIf (config.gui.available && cfg.enable) {
    terminals.${cfg.preferred}.enable = true;
  };
}
