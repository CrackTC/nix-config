{ pkgs, extraRepos, ... }: {

  imports = [
    extraRepos.myRepo.modules.hpfan
    ./hardware-configuration.nix
  ];

  sorac.host = {
    bluetooth.enable = true;
    dev.enable = true;
    laptop.enable = true;
    network.inJLU = true;
    newIntel = {
      enable = true;
      pciBusId = "PCI:0:2:0";
    };
    nvidia = {
      enable = true;
      pciBusId = "PCI:1:0:0";
    };
    powerManagement.enable = true;
    ssd.enable = true;
    timeZone = "Asia/Shanghai";
    coredump.enable = false;
    gui.enable = true;
    firewallCommonPorts = true;
    font.enable = true;
    gvfs.enable = true;
    joycond.enable = true;
    man.enable = true;
    monitors = [
      {
        name = "eDP-1";
        weight = 2560;
        height = 1440;
        refresh = 240;
        left = 0;
        top = 0;
        scale = 1.25;
      }
      {
        name = "DP-1";
        weight = 2560;
        height = 1440;
        refresh = 120;
        left = 2048; # 2560 / 1.25
        top = 0;
        scale = 1.25;
      }
    ];
    pipewire = {
      enable = true;
      lowLatency = true;
    };
    ssh.enable = false;
    virt = {
      pciPassIds = [ "10de:24a0" "10de:228b" ];
      kvmfrSizeMb = 32;
    };
    wacom.enable = true;
  };

  services.hpfan = {
    enable = true;
    wall = 70000;
    pwmFile = "/sys/class/hwmon/hwmon5/pwm1_enable";
  };

  environment.systemPackages = [ pkgs.cifs-utils ];

  # boot.supportedFilesystems = [ "ntfs" ];

  fileSystems = {
    # "/mnt/windows" = {
    #   device = "/dev/disk/by-uuid/D66C452C6C450927";
    #   fsType = "ntfs3";
    # };

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
