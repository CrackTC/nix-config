{
  config,
  pkgs,
  lib,
  extraRepos,
  ...
}:
let
  cfg = config.programs.utility.rofi;
  display = ">";
  font = "sans-serif bold 20";
in
{
  imports = [
    ./theme.nix
    ./rbw.nix
  ];

  options.programs.utility.rofi = {
    enable = lib.mkEnableOption "rofi";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi;
      terminal = lib.getExe config.terminal.preferredPackage;
      extraConfig = {
        width = 400;
        lines = 20;
        show-icons = true;
        line-margin = 14;
        display-ssh = display;
        display-run = display;
        display-drun = display;
        display-window = display;
        display-combi = display;
      };
      inherit font;
      plugins =
        map
          (
            p:
            p.override {
              inherit (pkgs) rofi-unwrapped;
            }
          )
          [
            pkgs.rofi-calc
            extraRepos.myRepo.rofi-ts
          ];
    };
  };
}
