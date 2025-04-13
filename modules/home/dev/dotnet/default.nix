{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.dotnet;
  combined = pkgs.dotnetCorePackages.combinePackages (
    map (sdk: pkgs.dotnetCorePackages."dotnet_${toString sdk}".sdk) cfg.sdks
  );
in
{
  imports = [ ./rider.nix ];
  options.dotnet = {
    enable = lib.mkEnableOption "dotnet";
    sdks = lib.mkOption {
      type = lib.types.listOf lib.types.int;
      default = [
        10
        9
        8
      ];
      description = "List of .NET SDK versions to install.";
    };
  };

  config = lib.mkIf cfg.enable {
    rider.enable = true;
    hmConfig = {
      home = {
        sessionVariables = {
          DOTNET_ROOT = "${combined}/share/dotnet";
          DOTNET_PATH = "${combined}/bin/dotnet";
        };
        packages = with pkgs; [
          combined
          csharprepl
        ];
      };
    };
  };
}
