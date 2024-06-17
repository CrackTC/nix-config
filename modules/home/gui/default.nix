{ config, lib, hostConfig, ... }: {
  imports = [
    ./discord.nix
    ./dunst
    ./firefox
    ./imv.nix
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
    ./qq.nix
    ./showmethekey.nix
    ./svp.nix
    ./telegram.nix
    ./terminal
    ./thunderbird.nix
    ./vivaldi
    ./vscode
    ./wpsoffice.nix
  ];

  options.gui = {
    enable = lib.mkEnableOption "GUI applications";
  };

  config = lib.mkIf (hostConfig.gui.enable && config.gui.enable) {
    discord.enable = true;
    dunst.enable = true;
    firefox.enable = true;
    gui.misc.enable = true;
    imv.enable = true;
    imwheel.enable = true;
    libreoffice.enable = true;
    logisim.enable = true;
    nautilus.enable = true;
    obs-studio.enable = true;
    obsidian.enable = true;
    okular.enable = true;
    qq.enable = true;
    showmethekey.enable = true;
    telegram.enable = true;
    terminal.enable = true;
    thunderbird.enable = true;
    vivaldi.enable = true;
    vscode.enable = true;
  };
}
