{ pkgs, info, ... }: {
  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark;
  users.users.${info.username}.extraGroups = [ "wireshark" ];
  security.pki.certificateFiles = [
    ../home/chen/dev/mitm/mitmproxy-ca-cert.pem
  ];
}
