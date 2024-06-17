{ lib, ... }:
{
  options.jetbrains = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "JetBrains IDEs installed";
    };
  };
}
