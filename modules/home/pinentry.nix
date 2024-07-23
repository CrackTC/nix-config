{ config, pkgs, lib, ... }:
let cfg = config.pinentry; in {
  options.pinentry = lib.mkOption {
    description = "default pinentry";
    type = lib.types.str;
    default = "pinentry-tty";
  };

  config.osConfig.programs.gnupg.agent = {
    enable = true;

    # https://github.com/nix-community/home-manager/issues/3095
    settings.pinentry-program =
      let
        wrapped = pkgs.writeShellScript "${cfg}-wrapped" ''
          ${lib.getExe pkgs.bash} -lc ${lib.getExe pkgs.${cfg}}
        '';
      in
      lib.mkForce (lib.mkForce "${wrapped}");
  };
}
