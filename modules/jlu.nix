{ pkgs, info, ... }: {
  networking = {
    networkmanager = {
      enable = true;
      dispatcherScripts = [
        {
          source = pkgs.writeShellScript "jlu-drcom" ''
            INTERFACE=$1
            ACTION=$2

            SSID=`${pkgs.wirelesstools}/bin/iwconfig $INTERFACE | grep ESSID | awk '{print $4}' | sed 's/ESSID:"\(.*\)"/\1/'`

            if [[ `echo -e "$SSID"` != JLU* ]]; then
                exit 0
            fi

            if [ "$ACTION" = "up" ]; then
                pkill jlu-drcom
                /home/${info.username}/repos/dr-jlu-linux/bin/jlu-drcom&
            fi
          '';
        }
      ];
    };
  };
}
