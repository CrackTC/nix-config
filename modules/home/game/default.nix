{ config, lib, ... }: {
  imports = [
    ./beatoraja.nix
    ./bottles.nix
    ./gamescope.nix
    ./osu.nix
    ./steam.nix
    ./sunshine.nix
  ];

  options.game = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "User plays games";
    };
  };

  config = lib.mkIf config.game.enable {
    beatoraja.enable = true;
    bottles.enable = true;
    gamescope.enable = true;
    osu.enable = true;
    steam.enable = true;
    sunshine.enable = true;
  };
}
