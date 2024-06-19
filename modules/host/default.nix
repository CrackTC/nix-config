{ config, pkgs, lib, ... }:
let cfg = config.sorac.host; in {
  imports = [
    ./bluetooth
    ./coredump.nix
    ./dbus.nix
    ./dev
    ./firewall.nix
    ./fonts.nix
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
        experimental-features = [ "nix-command" "flakes" ];
        system-features = [ "gccarch-${cfg.cpu}" "big-parallel" ];
        auto-optimise-store = true;
      };

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 1w";
      };
    };

    boot = {
      kernelPackages = pkgs.linuxPackages_zen;
      kernelParams = [
        # "module_blacklist=i915"
        # "ibt=off"
      ];
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
      supportedLocales = [ "en_US.UTF-8/UTF-8" "zh_CN.UTF-8/UTF-8" ];
    };

    environment.systemPackages = [ pkgs.vim pkgs.git ];
    system.stateVersion = "23.05";
  };
}
