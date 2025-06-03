{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.sorac.host;
in
{
  imports = [
    ./bluetooth
    ./coredump.nix
    ./dbus.nix
    ./firewall.nix
    ./fonts
    ./gvfs.nix
    ./hostName
    ./joycond.nix
    ./laptop
    ./man.nix
    ./monitor.nix
    ./network
    ./newIntel
    ./nvidia
    ./pipewire.nix
    ./polkit.nix
    ./powerManagement
    ./program.nix
    ./sops.nix
    ./ssd
    ./ssh.nix
    ./timeZone
    ./virt.nix
    ./wacom.nix
    ./wireguard.nix
  ];

  options.sorac.host = {
    gui = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Host has GUI";
      };
    };
    cpu = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "CPU architecture";
    };
    system = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "System type";
    };
  };

  config = {
    nix = {
      settings = {
        trusted-users = [ "@wheel" ];
        experimental-features = [
          "nix-command"
          "flakes"
          "pipe-operators"
        ];
        system-features = [
          "gccarch-${cfg.cpu}"
          "big-parallel"
        ];
        auto-optimise-store = true;
        substituters = [
          "https://mirrors.ustc.edu.cn/nix-channels/store"
          "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
          "https://nix-community.cachix.org"
          "https://cracktc.cachix.org"
          "https://hyprland.cachix.org"
          "https://ghostty.cachix.org"
          "https://cache.nixos.org/"
        ];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "cracktc.cachix.org-1:2hSlXvkhNchqB0wo+nz13bWdJo9/nxrAi/masgZCm2I="
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        ];
      };

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
    };

    boot = {
      kernelPackages = pkgs.linuxPackages_latest;
      loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot = {
          enable = true;
          configurationLimit = 10;
          consoleMode = "max";
        };
      };
    };

    i18n = {
      defaultLocale = "en_US.UTF-8";
      supportedLocales = [
        "en_US.UTF-8/UTF-8"
        "zh_CN.UTF-8/UTF-8"
      ];
    };

    environment.systemPackages = [
      pkgs.vim
      pkgs.git
      pkgs.nh
    ];
    system.stateVersion = "23.05";
  };
}
