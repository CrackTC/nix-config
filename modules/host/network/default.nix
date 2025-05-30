{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.sorac.host.network;
in
{
  options.sorac.host.network.inJLU = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Host is in JLU :(";
  };

  config.networking = {
    networkmanager = {
      enable = true;
      wifi = {
        backend = "iwd";
        powersave = true;
      };
      dispatcherScripts = lib.mkIf cfg.inJLU [
        {
          source = pkgs.writeShellScript "jlu-drcom" ''
            INTERFACE=$1
            ACTION=$2

            SSID=`${pkgs.wirelesstools}/bin/iwconfig $INTERFACE | grep ESSID | ${lib.getExe pkgs.gawk} '{print $4}' | sed 's/ESSID:"\(.*\)"/\1/'`

            if [[ `echo -e "$SSID"` != JLU* ]]; then
                exit 0
            fi

            if [ "$ACTION" = "up" ]; then
                ${pkgs.procps}/bin/pkill jlu-drcom
                /home/chen/repos/dr-jlu-linux/bin/jlu-drcom&
            fi
          '';
        }
      ];
    };
  };
}
