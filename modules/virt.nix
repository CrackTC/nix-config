{ pkgs, config, info, ... }: {
  boot = {
    kernelParams = [ "intel_iommu=on" "iommu=pt" ];
    kernelModules = [
      "vfio"
      "vfio_iommu_type1"
      "vfio_pci"
      "vfio_virqfd"
      "kvmfr"
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
  '';
  virtualisation.libvirtd = {
    enable = true;
    qemu.package = pkgs.qemu_kvm;
    qemu.verbatimConfig = ''
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
  # systemd.tmpfiles.settings."10-looking-glass.conf" = {
  #   "/dev/shm/looking-glass" = {
  #     f = {
  #       user = info.username;
  #       group = "kvm";
  #       mode = "0660";
  #     };
  #   };
  # };
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "root" info.username ];
  environment.systemPackages = with pkgs; [ virtiofsd spice-gtk looking-glass-client ];
}
