{ config, pkgs, lib, ... }:
let cfg = config.sorac.host.nvidia; in {
  options.sorac.host.nvidia = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Host has Nvidia GPU";
    };
    pciBusId = lib.mkOption {
      type = lib.types.str;
      default = "PCI:1:0:0";
      description = "PCI Bus ID of the Nvidia GPU";
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
        extraPackages = [ pkgs.libvdpau-va-gl ];
      };

      nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        modesetting.enable = true;
        open = true;
        prime.nvidiaBusId = cfg.pciBusId;
        nvidiaSettings = false;
      };
    };
  };
}
