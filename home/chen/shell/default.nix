{
  imports = [
    ./fish.nix
    ./pwsh.nix
  ];
  programs.atuin.enable = true;
  home.shellAliases = {
    c = "clear";
    d = "disown";
    s = "fastfetch";
    la = "ls -al";
    lg = "lazygit";
    ra = "joshuto";
  };
}
