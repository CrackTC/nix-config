{ config, lib, name, ... }: {
  imports = [
    ./fish.nix
    ./pwsh.nix
  ];

  options.shell.preferred = lib.mkOption {
    type = lib.types.str;
    default = "fish";
    description = "The shell to use";
  };

  config = {
    shells.${config.shell.preferred}.enable = true;
    hmConfig.home.shellAliases = {
      c = "clear";
      d = "disown";
      la = "ls -al";
      s = lib.mkIf config.fastfetch.enable "fastfetch";
      lg = lib.mkIf config.lazygit.enable "lazygit";
      ra = lib.mkIf config.joshuto.enable "joshuto";
    };

    osConfig = {
      users.users.${name}.shell = "/run/current-system/sw/bin/${config.shell.preferred}";
    };
  };
}
