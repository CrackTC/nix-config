{ config, pkgs, lib, name, hostConfig, osConfig, ... }:
let cfg = config.virt; in {
  options.virt = {
    enable = lib.mkEnableOption "virt";
  };

  config = lib.mkIf cfg.enable {
    osConfig = {
      programs.virt-manager.enable = true;
      virtualisation.libvirtd = {
        enable = true;
        qemu.package = pkgs.qemu_kvm;
        onBoot = "ignore";
        onShutdown = "shutdown";
      };
      users.users.${name}.extraGroups = [ "libvirtd" "kvm" ];
      environment.systemPackages = lib.mkMerge [
        [ pkgs.virtiofsd ]
        (lib.mkIf (hostConfig.gui.enable && config.gui.enable) [
          pkgs.spice-gtk

          # https://github.com/NixOS/nixpkgs/issues/328643
          (pkgs.looking-glass-client.overrideAttrs {
            patches = [
              (pkgs.fetchpatch {
                url = "https://github.com/gnif/LookingGlass/commit/20972cfd9b940fddf9e7f3d2887a271d16398979.patch";
                hash = "sha256-CqB8AmOZ4YxnEsQkyu/ZEaun6ywpSh4B7PM+MFJF0qU=";
                stripLen = 1;
              })
            ];
          })
        ])
      ];

      specialisation = lib.mkIf hostConfig.nvidia.enable {
        NvPCIPassthrough.configuration = {
          system.nixos.tags = [ "nv-pci-pass-through" ];
          boot = {
            kernel.sysctl = {
              "vm.nr_hugepages" = 16384;
              "vm.hugetlb_shm_group" = osConfig.users.groups.libvirtd.gid;
            };
            kernelParams = [ "intel_iommu=on" "iommu=pt" ];
            kernelModules = [
              "vfio"
              "vfio-iommu-type1"
              "vfio-pci"
              "vfio-virqfd"
              "kvmfr"
            ];
            blacklistedKernelModules = [
              "nouveau"
              "nvidiafb"
              "nvidia"
              "nvidia-uvm"
              "nvidia-drm"
              "nvidia-modeset"
            ];
            extraModulePackages = with osConfig.boot.kernelPackages; [
              # https://github.com/NixOS/nixpkgs/issues/328643
              (kvmfr.overrideAttrs {
                patches = [
                  (pkgs.fetchpatch {
                    url = "https://github.com/gnif/LookingGlass/commit/7305ce36af211220419eeab302ff28793d515df2.patch";
                    hash = "sha256-97nZsIH+jKCvSIPf1XPf3i8Wbr24almFZzMOhjhLOYk=";
                    stripLen = 1;
                  })
                ];
              })
            ];
            extraModprobeConfig = ''
              options vfio-pci ids=${builtins.concatStringsSep "," hostConfig.virt.pciPassIds}
              options kvmfr static_size_mb=${toString hostConfig.virt.kvmfrSizeMb}
              options kvm ignore_msrs=1
            '';
          };

          services.udev.extraRules = ''
            SUBSYSTEM=="kvmfr", OWNER="root", GROUP="kvm", MODE="0660"
          '';

          environment.etc = {
            "looking-glass-client.ini".text = ''
              [app]
              shmFile=/dev/kvmfr0

              [input]
              grabKeyboardOnFocus=yes
              escapeKey=KEY_RIGHTCTRL
              rawMouse=yes
            '';

            "SSDT1.dat".source = ./SSDT1.dat;
          };

          virtualisation.libvirtd.qemu.verbatimConfig = ''
            nvram = [ "${pkgs.OVMF}/FV/OVMF.fd:${pkgs.OVMF}/FV/OVMF_VARS.fd" ]
            cgroup_device_acl = [
              "/dev/null", "/dev/full", "/dev/zero",
              "/dev/random", "/dev/urandom",
              "/dev/ptmx", "/dev/kvm", "/dev/kqemu",
              "/dev/rtc","/dev/hpet", "/dev/vfio/vfio",
              "/dev/kvmfr0"
            ]
          '';
        };
      };
    };
  };
}
