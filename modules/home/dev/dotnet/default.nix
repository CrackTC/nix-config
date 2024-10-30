{ config, pkgs, lib, ... }:
let
  cfg = config.dotnet;
  combined = with pkgs; dotnetCorePackages.combinePackages (map (sdk: dotnetCorePackages."sdk_${toString sdk}_0") cfg.sdks);
in
{
  imports = [ ./rider.nix ];
  options.dotnet = {
    enable = lib.mkEnableOption "dotnet";
    sdks = lib.mkOption {
      type = lib.types.listOf lib.types.int;
      default = [ 9 8 ];
      description = "List of .NET SDK versions to install.";
    };
    root = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Root directory for .NET SDKs and runtimes.";
    };
  };

  config = lib.mkIf cfg.enable {
    dotnet.root = "${combined}";
    rider.enable = true;
    hmConfig = {
      home.packages = with pkgs; [
        combined

        csharprepl
      ];
    };
  };
}
