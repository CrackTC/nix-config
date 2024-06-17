{ config, lib, ... }:
let
  cfg = config.rofi;
  # hacky alternative copied from https://github.com/nix-community/home-manager/blob/8d5e27b4807d25308dfe369d5a923d87e7dbfda3/modules/programs/rofi.nix#L260
  # since we can't get home-manager's config argument outside of home-manager
  mkLiteral = value: {
    _type = "literal";
    inherit value;
  };
in
{
  config.hmConfig.programs.rofi.theme = lib.mkIf cfg.enable {
    "*" = {
      nord0 = mkLiteral "#2e3440";
      nord1 = mkLiteral "#3b4252";
      nord2 = mkLiteral "#434c5e";
      nord3 = mkLiteral "#4c566a";
      nord4 = mkLiteral "#d8dee9";
      nord5 = mkLiteral "#e5e9f0";
      nord6 = mkLiteral "#eceff4";
      nord7 = mkLiteral "#8fbcbb";
      nord8 = mkLiteral "#88c0d0";
      nord9 = mkLiteral "#81a1c1";
      nord10 = mkLiteral "#5e81ac";
      nord11 = mkLiteral "#bf616a";
      nord12 = mkLiteral "#d08770";
      nord13 = mkLiteral "#ebcb8b";
      nord14 = mkLiteral "#a3be8c";
      nord15 = mkLiteral "#b48ead";

      transparent = mkLiteral "#2e344000";
      foreground = mkLiteral "@nord9";
      background = mkLiteral "#ccffeedd";
      background-color = mkLiteral "@transparent";
      highlight = mkLiteral "underline bold #eceff4";
    };


    window = {
      anchor = mkLiteral "center";
      transparency = "screenshot";
      padding = mkLiteral "0px";
      border = mkLiteral "3px";
      border-color = mkLiteral "@nord7";
      border-radius = mkLiteral "20px";

      background-color = mkLiteral "@transparent";
      spacing = 0;
      children = map mkLiteral [ "mainbox" ];
      orientation = mkLiteral "horizontal";

      width = mkLiteral "30%";
    };

    mainbox = {
      spacing = 0;
      children = map mkLiteral [ "inputbar" "message" "listview" ];
    };

    inputbar = {
      color = mkLiteral "@nord7";
      padding = mkLiteral "11px";
      background-color = mkLiteral "#3b4252BB";

      border = mkLiteral "0px";
      border-radius = mkLiteral "20px 20px 0 0";
    };

    "entry, prompt, case-indicator" = {
      text-font = mkLiteral "inherit";
      text-color = mkLiteral "inherit";
    };

    prompt = {
      margin = mkLiteral "0 0.3em 0 0";
    };

    message = {
      padding = mkLiteral "10px";
      border-color = mkLiteral "@foreground";
      border = mkLiteral "0px";
      background-color = mkLiteral "rgba(46, 52, 64, 0.7)";
    };

    listview = {
      padding = mkLiteral "8px";
      border-radius = mkLiteral "0 0 20px 20px";
      background-color = mkLiteral "rgba(46, 52, 64, 0.7)";
      dynamic = false;
      lines = 10;
      coloumns = 1;
    };

    element = {
      border-radius = mkLiteral "10px";
      background-color = mkLiteral "@transparent";
      color = mkLiteral "@foreground";
      text-color = mkLiteral "@nord4";
    };

    "element selected.normal" = {
      background-color = mkLiteral "@nord7";
      text-color = mkLiteral "@nord0";
    };

    element-text = {
      padding = mkLiteral "4px 0 0 0";
      background-color = mkLiteral "inherit";
      text-color = mkLiteral "inherit";
    };

    element-icon = {
      size = mkLiteral "40px";
      padding = mkLiteral "3px";
    };

    textbox = {
      color = mkLiteral "@nord0";
      padding = mkLiteral "10px";
      background-color = mkLiteral "@nord8";
      border-radius = mkLiteral "10px";
      font = "sans-serif bold 15";
    };

    button = {
      padding = mkLiteral "6px";
      color = mkLiteral "@foreground";
    };

    "button selected normal" = {
      border = mkLiteral "2px 0 2px 2px";
      border-color = mkLiteral "@foreground";
    };
  };
}
