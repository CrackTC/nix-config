{ pkgs, info, ... }: {
  boot.kernelParams = [ "intel_iommu=on" "iommu=pt" ];
  virtualisation.libvirtd = {
    enable = true;
    qemu.package = pkgs.qemu_kvm;
  };
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "root" info.username ];
  environment.systemPackages = with pkgs; [ virtiofsd spice-gtk ];
}
