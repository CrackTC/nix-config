{
  imports = [
    ./fish.nix
    ./pwsh.nix
  ];
  home.shellAliases = {
    c = "clear";
    d = "disown";
    s = "fastfetch";
    la = "ls -al";
    lg = "lazygit";
    ra = "joshuto";
  };
}
