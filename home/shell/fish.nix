{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "eclm";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "theme-eclm";
          rev = "185c84a41947142d75c68da9bc6c59bcd32757e7";
          sha256 = "OBku4wwMROu3HQXkaM26qhL0SIEtz8ShypuLcpbxp78=";
        };
      }
    ];
    functions = {
      fish_greeting = "";
      fish_user_key_bindings = ''
        fish_default_key_bindings -M insert
        fish_vi_key_bindings --no-erase insert

        bind n down-or-search
        bind -M visual n down-or-search

        bind e up-or-search
        bind -M visual e up-or-search

        bind i forward-char
        bind -M visual i forward-char

        bind -m insert u repaint-mode
        bind -m insert U beginning-of-line repaint-mode

        bind l undo
        bind \cp redo

        bind -m insert y insert-line-under repaint-mode
        bind -m insert Y insert-line-over repaint-mode

        bind ss kill-whole-line
      '';
      enbase = "echo -n $argv | base64";
      debase = "echo -n $argv | base64 -d";
      conda = ''
        fhs -C 'eval "$(micromamba shell hook --shell=fish)"'
      '';
    };
  };
}
