{ config, lib, ... }:
{
  imports = [
    ./editor
    ./git.nix
    ./ripgrep.nix
    ./ssh
  ];

  options.tui = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable tui essentials";
    };
  };

  config = lib.mkIf config.tui.enable {
    git.enable = true;
    editor.enable = true;
    ripgrep.enable = true;
    ssh.enable = true;
  };
}
