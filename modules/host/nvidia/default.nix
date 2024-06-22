{ config, pkgs, lib, ... }:
let cfg = config.sorac.host.nvidia; in {
  options.sorac.host.nvidia = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Host has Nvidia GPU";
    };
    pciBusId = {
      domain = lib.mkOption {
        type = lib.types.str;
        default = "0000";
        description = "PCI domain of the Nvidia GPU";
      };
      bus = lib.mkOption {
        type = lib.types.str;
        default = "01";
        description = "PCI bus of the Nvidia GPU";
      };
      slot = lib.mkOption {
        type = lib.types.str;
        default = "00";
        description = "PCI slot of the Nvidia GPU";
      };
      function = lib.mkOption {
        type = lib.types.str;
        default = "0";
        description = "PCI function of the Nvidia GPU";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    boot = {
      extraModprobeConfig = "options nvidia NVreg_EnableMSI=1";
      kernelModules = [ "nvidia_uvm" ];
    };

    environment.systemPackages = [
      pkgs.nvtopPackages.full
      pkgs.libva-utils
      pkgs.vulkan-tools
    ];

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware = {
      opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
        extraPackages = [ pkgs.libvdpau-va-gl pkgs.vaapiVdpau ];
      };

      nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        modesetting.enable = true;
        open = true;
        prime.nvidiaBusId = "PCI:${cfg.pciBusId.bus}:${cfg.pciBusId.slot}:${cfg.pciBusId.function}";
        nvidiaSettings = false;
      };
    };
  };
}
