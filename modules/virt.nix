{ pkgs, config, info, ... }: {
  specialisation = {
    nv-pci-pass-through.configuration = {
      system.nixos.tags = [ "nv-pci-pass-through" ];
      boot = {
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
        extraModulePackages = with config.boot.kernelPackages; [ kvmfr ];
        extraModprobeConfig = ''
          options vfio-pci ids=10de:24a0,10de:228b
          options kvmfr static_size_mb=32
        '';
      };

      services.udev.extraRules = ''
        SUBSYSTEM=="kvmfr", OWNER="${info.username}", GROUP="kvm", MODE="0660"
      '';

      environment.etc."looking-glass-client.ini".text = ''
        [app]
        shmFile=/dev/kvmfr0

        [input]
        grabKeyboardOnFocus=yes
        escapeKey=KEY_RIGHTCTRL
        rawMouse=yes
      '';

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
  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu.package = pkgs.qemu_kvm;
    onBoot = "ignore";
    onShutdown = "shutdown";
  };
  users.groups.libvirtd.members = [ "root" info.username ];
  environment.systemPackages = with pkgs; [ virtiofsd spice-gtk looking-glass-client ];
}
