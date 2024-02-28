{ pkgs, ... }: {
  home.packages = with pkgs; [
    jdk8
    jetbrains.idea-ultimate
  ];
}
