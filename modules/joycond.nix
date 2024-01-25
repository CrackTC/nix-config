{
  services.joycond.enable = true;
  boot.initrd.kernelModules = [ "hid_nintendo" ];
}
