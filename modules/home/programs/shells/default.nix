{
  config,
  lib,
  name,
  ...
}:
{
  imports = [
    ./bash.nix
    ./fish.nix
    ./pwsh.nix
    ./zsh.nix
  ];

  options.programs.preferredShell = lib.mkOption {
    type = lib.types.str;
    default = "bash";
    description = "The shell to use";
  };

  config =
    let
      preferred = config.programs.preferredShell;
    in
    {
      programs.shells.${preferred}.enable = true;
      hmConfig.home.shellAliases = {
        c = "clear";
        d = "disown";
        la = "ls -al";
        s = lib.mkIf config.programs.utility.fastfetch.enable "fastfetch";
        lg = lib.mkIf config.programs.utility.lazygit.enable "lazygit";
        ra = lib.mkMerge [
          (lib.mkIf config.programs.utility.joshuto.enable "joshuto")
          (lib.mkIf config.programs.utility.yazi.enable "yy")
        ];
      };

      osConfig.users.users.${name}.shell = "/run/current-system/sw/bin/${preferred}";
    };
}
