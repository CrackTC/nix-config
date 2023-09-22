{ pkgs, info, ... }: {
  networking = {
    networkmanager = {
      enable = true;
      dispatcherScripts = [
        {
          source = pkgs.writeShellScript "jlu-drcom" ''
            if [ "$2" = "up" ]; then
                pkill jlu-drcom
                /home/${info.username}/repos/dr-jlu-linux/bin/jlu-drcom&
            fi
          '';
        }
      ];
    };
  };
}
