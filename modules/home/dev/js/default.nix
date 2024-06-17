{ config, pkgs, lib, ... }:
let cfg = config.js; in {
  imports = [ ./node.nix ];

  options.js = {
    enable = lib.mkEnableOption "js";
  };

  config = lib.mkIf cfg.enable {
    node.enable = true;
    hmConfig = {
      home.packages = with pkgs; [
        yarn
        deno
      ];
    };
  };
}
