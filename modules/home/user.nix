{
  config,
  lib,
  name,
  ...
}:
{
  options = {
    uid = lib.mkOption {
      type = lib.types.int;
      default = 1000;
      description = "User ID";
    };
    nickname = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Nickname";
    };
    powerful = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Powerful user";
    };
  };

  config = {
    osConfig = {
      users.users.${name} = {
        inherit (config) uid;
        isNormalUser = true;
        description = config.nickname;
        extraGroups = lib.mkIf config.powerful [ "wheel" ];
      };

      security.sudo.extraRules = lib.mkIf config.powerful [
        {
          users = [ name ];
          commands = [
            {
              command = "ALL";
              options = [ "NOPASSWD" ];
            }
          ];
        }
      ];
    };
  };
}
