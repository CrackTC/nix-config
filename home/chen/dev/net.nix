{ pkgs, ... }: {
  home.packages = with pkgs; [
    mitmproxy
    rlwrap
    websocat
  ];

  home.file.".mitmproxy" = {
    source = ./mitm;
    recursive = true;
  };
}
