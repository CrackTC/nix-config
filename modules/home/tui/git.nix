{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.git;
in
{
  options.git = {
    enable = lib.mkEnableOption "git";
    key = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "The GPG key to use for signing commits, can be retrieved from `gpg --list-secret-keys --keyid-format=long`";
    };
  };

  config.hmConfig = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = config.nickname;
      userEmail = config.email;
      signing = {
        inherit (cfg) key;
        signByDefault = true;
      };
      extraConfig.init.defaultBranch = "main";
      lfs.enable = true;
    };

    home.packages = with pkgs; [ gnupg ];
  };
}
