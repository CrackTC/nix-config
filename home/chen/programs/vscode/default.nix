{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = (pkgs.vscode.override {
      commandLineArgs = "--ozone-platform-hint=wayland --enable-wayland-ime";
    }).fhs;
  };
}
