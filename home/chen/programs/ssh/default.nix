{
  programs.ssh.enable = true;
  programs.ssh.extraConfig = ''
    Host github.com
        Hostname ssh.github.com
        Port 443
        User git
  '';
}
