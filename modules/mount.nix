{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.cifs-utils ];
  fileSystems = {
    "/mnt/windows" = {
      device = "/dev/disk/by-uuid/D66C452C6C450927";
      fsType = "ntfs";
    };

    "/mnt/lib" = {
      device = "/dev/disk/by-uuid/f542c9db-e4ae-406b-a7e0-bd0bc9cc7a61";
    };

    "/mnt/smb/nas" = {
      device = "//cracktc.tpddns.cn/nas";
      fsType = "cifs";
      options =
        let
          automount_opts = [
            "x-systemd.automount"
            "noauto"
            "x-systemd.idle-timeout=60"
            "x-systemd.device-timeout=5s"
            "x-systemd.mount-timeout=5s"
          ];
        in
        automount_opts ++ [
          "credentials=/run/secrets/nas_credentials"
          "iocharset=utf8"
          "uid=1000"
          "gid=100"
          "sec=ntlmssp"
          "rw"
          "port=446"
        ];
    };

    # "/home/chen/net/nas" = {
    #   device = "cracktc.tpddns.cn:/volume1/nas";
    #   fsType = "nfs";
    #   options = [
    #     "x-systemd.automount"
    #     "noauto"
    #     "x-systemd.idle-timeout=60"
    #     "x-systemd.device-timeout=5s"
    #     "x-systemd.mount-timeout=5s"
    #   ];
    # };
  };
}
