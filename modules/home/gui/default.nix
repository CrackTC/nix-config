{
  config,
  lib,
  hostConfig,
  ...
}:
{
  imports = [
    ./chrome
    ./dunst
    ./firefox
    ./imwheel
    ./libreoffice.nix
    ./logisim.nix
    ./misc.nix
    ./nautilus.nix
    ./neovide.nix
    ./obs-studio.nix
    ./obsidian.nix
    ./okular.nix
    ./onlyoffice.nix
    ./pavucontrol.nix
    ./showmethekey.nix
    ./terminal
    ./thunderbird.nix
    ./vivaldi
    ./vscode
    ./wpsoffice.nix
  ];

  options.gui = {
    enable = lib.mkEnableOption "GUI applications";
    available = lib.mkOption {
      type = lib.types.bool;
      description = "Whether GUI actually available.";
      default = false;
    };
  };

  config = lib.mkIf (hostConfig.gui.enable && config.gui.enable) {
    gui.available = true;
    chrome.enable = true;
    dunst.enable = true;
    gui.misc.enable = true;
    libreoffice.enable = true;
    logisim.enable = true;
    nautilus.enable = true;
    obs-studio.enable = true;
    obsidian.enable = true;
    okular.enable = true;
    showmethekey.enable = true;
    terminal.enable = true;
    thunderbird.enable = true;
    # vivaldi.enable = true;
    vscode.enable = true;
  };
}
