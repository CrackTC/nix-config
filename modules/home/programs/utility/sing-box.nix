{
  config,
  name,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.programs.utility.sing-box;
  sing-box = pkgs.sing-box.overrideAttrs rec {
    version = "1.12.0-alpha.21";
    src = pkgs.fetchFromGitHub {
      owner = "SagerNet";
      repo = "sing-box";
      rev = "v${version}";
      hash = "sha256-dsgNe6X446KoAWh1vKPGgqdDwg8N76tT/3Hf752vMsY=";
    };
    vendorHash = "sha256-mS2b52uKbYkv8g5bfrNSyPre/OaKwovhZBC0Abc+Nes=";
  };
in
{
  options.programs.utility.sing-box = {
    enable = lib.mkEnableOption "sing-box";
  };

  config = lib.mkIf cfg.enable {
    osConfig = {
      systemd.services.sing-box = {
        description = "fetch config & run sing-box on startup";
        after = [ "network-online.target" ];
        requires = [ "network-online.target" ];
        serviceConfig = {
          ExecStart = pkgs.writeScript "sing-box.fish" ''
            #!${lib.getExe pkgs.fish}
            ${lib.getExe sing-box} run -D /home/${name}/.config/sing-box
          '';
        };
        wantedBy = [ "multi-user.target" ];
      };
    };
  };
}
