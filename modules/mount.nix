{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.cifs-utils ];
  fileSystems = {
    "/mnt/windows" = {
      device = "/dev/disk/by-uuid/C642192442191B2F";
      fsType = "ntfs";
    };

    # "/mnt/smb/nas" = {
    #   device = "//cracktc.tpddns.cn/nas";
    #   fsType = "cifs";
    #   options =
    #     let
    #       automount_opts = [
    #         "x-systemd.automount"
    #         "noauto"
    #         "x-systemd.idle-timeout=60"
    #         "x-systemd.device-timeout=5s"
    #         "x-systemd.mount-timeout=5s"
    #       ];
    #     in
    #     automount_opts ++ [
    #       "credentials=/run/secrets/nas_credentials"
    #       "iocharset=utf8"
    #       "uid=1000"
    #       "gid=100"
    #       "sec=ntlmssp"
    #       "rw"
    #       "port=446"
    #     ];
    # };

    "/home/chen/net/nas" = {
      device = "cracktc.tpddns.cn:/volume1/nas";
      fsType = "nfs";
      options = [
        "x-systemd.automount"
        "noauto"
        "x-systemd.idle-timeout=60"
        "x-systemd.device-timeout=5s"
        "x-systemd.mount-timeout=5s"
      ];
    };
  };
}
