{ pkgs, ... }: {
  home.file.".imwheelrc".source = ./.imwheelrc;
  home.packages = with pkgs; [ imwheel ];
}
