{ config, pkgs, lib, ... }:
let cfg = config.sorac.host.newIntel; in {
  options.sorac.host.newIntel = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Host has new Intel GPU";
    };
    pciBusId = {
      domain = lib.mkOption {
        type = lib.types.str;
        default = "0000";
        description = "PCI domain of the Intel GPU";
      };
      bus = lib.mkOption {
        type = lib.types.str;
        default = "00";
        description = "PCI bus of the Intel GPU";
      };
      slot = lib.mkOption {
        type = lib.types.str;
        default = "02";
        description = "PCI slot of the Intel GPU";
      };
      function = lib.mkOption {
        type = lib.types.str;
        default = "0";
        description = "PCI function of the Intel GPU";
      };
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
      nvidia.prime.intelBusId = "PCI:${cfg.pciBusId.bus}:${cfg.pciBusId.slot}:${cfg.pciBusId.function}";
    };
  };
}

