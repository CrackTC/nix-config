{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.cifs-utils ];
  fileSystems."/mnt/smb/nas" = {
    device = "//cracktc.tpddns.cn/nas";
    fsType = "cifs";
    options =
      let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in
      [ "${automount_opts},credentials=/run/secrets/nas_credentials,iocharset=utf8,uid=1000,gid=100,sec=ntlmssp,rw,port=446" ];
  };
  fileSystems."/home/chen/nas" = {
    device = "cracktc.tpddns.cn:/volume1/nas";
    fsType = "nfs";
  };
}
