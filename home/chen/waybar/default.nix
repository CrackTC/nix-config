{ ... }: {
  imports = [
    ./modules
    ./style.nix
  ];

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        spacing = 4;
        layer = "top";
        position = "top";
        height = 37;
        margin-top = 0;
        margin-left = 10;
        margin-right = 10;
      };
    };
  };
}
