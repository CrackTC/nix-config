{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix = {
    settings = {
      trusted-users = [ "chen" ];
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
  };

  boot = {
    initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
    extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
    supportedFilesystems = [ "ntfs" ];
    kernelParams = [ /* "module_blacklist=i915" */ "ibt=off" ];
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
    networkmanager = {
      enable = true;
      dispatcherScripts = [
        {
          source = pkgs.writeShellScript "jlu-drcom" ''
            if [ "$2" = "up" ]; then
                pkill jlu-drcom
                /home/chen/repos/dr-jlu-linux/bin/jlu-drcom&
            fi
          '';
        }
      ];
    };
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

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts
      source-han-sans
      source-han-serif
      maple-mono
      maple-mono-SC-NF
      twitter-color-emoji
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    ];

    fontconfig = {
      defaultFonts = {
        emoji = [ "Twitter Color Emoji" ];
        monospace = [
          "Maple Mono"
          "Noto Sans Mono CJK SC"
          "DejaVu Sans Mono"
        ];
        sansSerif = [
          "Noto Sans CJK SC"
          "Source Han Sans SC"
          "DejaVu Sans"
        ];
        serif = [
          "Noto Serif CJK SC"
          "Source Han Serif SC"
          "DejaVu Serif"
        ];
      };
    };
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  users.users.chen = {
    isNormalUser = true;
    description = "chen";
    shell = pkgs.fish;
    extraGroups = [ "wheel" "uinput" ];
  };

  environment.systemPackages = with pkgs; [ vim git libva-utils nvtop vulkan-tools ];

  programs = {
    fish.enable = true;
    gnupg = {
      agent = {
        enable = true;
        pinentryFlavor = "gtk2";
      };
    };
  };

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
    uinput.enable = true;
  };

  security.sudo.extraRules = [
    {
      users = [ "chen" ];
      commands = [{ command = "ALL"; options = [ "NOPASSWD" ]; }];
    }
  ];

  system.stateVersion = "23.05";
}

