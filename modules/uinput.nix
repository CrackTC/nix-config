{ info, ... }: {
  users.users.${info.username}.extraGroups = [ "uinput" ];
  hardware.uinput.enable = true;
}
