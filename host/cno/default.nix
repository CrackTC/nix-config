{ config, pkgs, info, extraRepos, ... }:

{
  imports = [
    ./hardware-configuration.nix
    extraRepos.myRepo.modules.hpfan
  ];

  nix = {
    settings = {
      trusted-users = [ "${info.username}" ];
      experimental-features = [ "nix-command" "flakes" ];
      system-features = [ "gccarch-alderlake" "big-parallel" ];
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
  };

  boot = {
    kernelModules = [ "ec_sys" ];
    extraModprobeConfig = ''
      options snd-hda-intel enable_msi=1
      options i915 enable_guc=2 enable_fbc=1
      options ec_sys write_support=1
    '';
    supportedFilesystems = [ "ntfs" ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      /* "module_blacklist=i915" */
      "ibt=off"
    ];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
        consoleMode = "max";
        extraEntries = {
          "arch.conf" = ''
            title Arch Linux
            efi /efi/ARCH/grubx64.efi
          '';
        };
      };
    };
  };

  networking = {
    hostName = "cno";
    proxy = {
      default = "http://127.0.0.1:7890";
      noProxy = "127.0.0.1,localhost,internal.domain";
    };
  };

  time.timeZone = "Asia/Shanghai";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "en_US.UTF-8/UTF-8" "zh_CN.UTF-8/UTF-8" ];
    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-chinese-addons
        fcitx5-anthy
      ];
    };
  };

  users.users.${info.username} = {
    isNormalUser = true;
    description = "${info.username}";
    shell = pkgs.fish;
    extraGroups = [ "wheel" ];
  };

  environment.systemPackages = with pkgs; [ vim git libva-utils nvtop vulkan-tools ];

  services = {
    udisks2.enable = true;
    xserver.videoDrivers = [ "nvidia" ];
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        libvdpau-va-gl
      ];
    };
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
      powerManagement.enable = true;
      open = true;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
      nvidiaSettings = true;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  powerManagement.enable = true;
  services.thermald.enable = true;
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };

  services.hpfan = {
    enable = true;
    wall = 60000;
  };

  services.blueman = {
    enable = true;
  };

  security.sudo.extraRules = [
    {
      users = [ "${info.username}" ];
      commands = [{ command = "ALL"; options = [ "NOPASSWD" ]; }];
    }
  ];

  system.stateVersion = "23.05";
}

