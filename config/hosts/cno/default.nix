{ pkgs, extraRepos, ... }:
{

  imports = [
    extraRepos.myRepo.modules.hpfan
    ./hardware-configuration.nix
  ];

  sorac.host = {
    bluetooth.enable = true;
    laptop.enable = true;
    network.inJLU = true;
    newIntel = {
      enable = true;
      pciBusId = {
        domain = "0000";
        bus = "00";
        slot = "02";
        function = "0";
      };
    };
    nvidia = {
      enable = true;
      pciBusId = {
        domain = "0000";
        bus = "01";
        slot = "00";
        function = "0";
      };
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
        refresh = 170;
        left = builtins.ceil (2560 / 1.25);
        top = 0;
        scale = 1.0;
      }
    ];
    pipewire = {
      enable = true;
      lowLatency = true;
    };
    ssh.enable = false;
    virt = {
      pciPassIds = [
        "10de:24a0"
        "10de:228b"
      ];
      kvmfrSizeMb = 32;
    };
    wacom.enable = true;
  };

  services.hpfan = {
    enable = true;
    wallLow = 70000;
    wallHigh = 90000;
    pwmFile = "/sys/class/hwmon/hwmon*/pwm1_enable";
  };

  environment.systemPackages = [ pkgs.cifs-utils ];

  sops.secrets.smb_credentials = { };
  fileSystems =
    let
      automount_opts = [
        "x-systemd.automount"
        "noauto"
        "x-systemd.idle-timeout=60"
        "x-systemd.device-timeout=5s"
        "x-systemd.mount-timeout=5s"
      ];
    in
    {
      "/mnt/smb/nas" = {
        device = "//192.168.96.1/nas";
        fsType = "cifs";
        options = automount_opts ++ [
          "credentials=/run/secrets/smb_credentials"
          "uid=1000"
          "gid=100"
          "rw"
        ];
      };
      "/mnt/smb/pi" = {
        device = "//192.168.96.2/pi";
        fsType = "cifs";
        options = automount_opts ++ [
          "credentials=/run/secrets/smb_credentials"
          "uid=1000"
          "gid=100"
          "rw"
        ];
      };
    };
}
