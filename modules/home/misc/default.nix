{ config, lib, ... }:
let cfg = config.misc; in {
  imports = [
    ./asciinema.nix
    ./bc.nix
    ./clash.nix
    ./fastfetch.nix
    ./jq.nix
    ./llama.nix
    ./zip.nix
  ];

  options.misc = {
    enable = lib.mkEnableOption "misc tools";
  };

  config = lib.mkIf cfg.enable {
    clash.enable = true;
    asciinema.enable = true;
    bc.enable = true;
    fastfetch.enable = true;
    jq.enable = true;
    llama.enable = true;
    zip.enable = true;
  };
}
