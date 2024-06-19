{ config, pkgs, lib, ... }:
let cfg = config.sorac.host.newIntel; in {
  options.sorac.host.newIntel = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Host has new Intel GPU";
    };
    pciBusId = lib.mkOption {
      type = lib.types.str;
      default = "PCI:0:2:0";
      description = "PCI Bus ID of the Intel GPU";
    };
  };

  config = lib.mkIf cfg.enable {
    boot.extraModprobeConfig = ''
      options i915 enable_guc=2 enable_fbc=1
      options snd-hda-intel enable_msi=1
    '';
    environment.systemPackages = [ pkgs.libva-utils pkgs.vulkan-tools ];

    hardware = {
      opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
        extraPackages = [
          pkgs.intel-media-driver
          pkgs.vpl-gpu-rt # for qsv support in obs-studio
        ];
      };
      nvidia.prime.intelBusId = cfg.pciBusId;
    };
  };
}

