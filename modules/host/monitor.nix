{ lib, ... }:
let
  monitor = {
    options = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "Name of the monitor";
      };
      weight = lib.mkOption {
        type = lib.types.int;
        default = 800;
        description = "Weight of the monitor";
      };
      height = lib.mkOption {
        type = lib.types.int;
        default = 600;
        description = "Height of the monitor";
      };
      refresh = lib.mkOption {
        type = lib.types.int;
        default = 60;
        description = "Refresh rate of the monitor";
      };
      left = lib.mkOption {
        type = lib.types.int;
        default = 0;
        description = "Left position of the monitor";
      };
      top = lib.mkOption {
        type = lib.types.int;
        default = 0;
        description = "Top position of the monitor";
      };
      scale = lib.mkOption {
        type = lib.types.float;
        default = 1.0;
        description = "Scale of the monitor";
      };
    };
  };
in
{
  options.sorac.host.monitors = lib.mkOption {
    type = lib.types.listOf (lib.types.submodule monitor);
    default = [ ];
    description = "List of monitors";
  };
}
