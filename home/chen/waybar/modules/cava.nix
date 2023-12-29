{ pkgs, ... }: {
  programs.waybar.settings.mainBar."custom/cava" = {
    exec = pkgs.writeShellScript "cava.sh" ''
      trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

      bar=" ▁▂▃▄▅▆▇█"
      dict="s/;//g;"

      # creating "dictionary" to replace char with bar
      i=0
      while [ $i -lt ''${#bar} ]
      do
          dict="''${dict}s/$i/''${bar:$i:1}/g;"
          i=$((i=i+1))
      done

      # make sure to clean pipe
      pipe="/tmp/cava.fifo"
      if [ -p $pipe ]; then
          unlink $pipe
      fi
      mkfifo $pipe

      # write cava config
      config_file="/tmp/waybar_cava_config"
      echo "
      [general]
      bars = 50
      framerate = 60

      [input]
      method = pipewire
      source = auto

      [output]
      method = raw
      raw_target = $pipe
      data_format = ascii
      ascii_max_range = 8

      [smoothing]
      noise_reduction = 10
      " > $config_file

      # run cava in the background
      cava -p $config_file &

      # reading data from fifo
      while read -r cmd; do
          echo $cmd | sed "$dict"
      done < $pipe
    '';
    # on-scroll-up = "playerctl -p spotify,edge,yesplaymusic previous";
    # on-scroll-down = "playerctl -p spotify,edge,yesplaymusic next";
    # on-click = "playerctl -p spotify,edge,yesplaymusic play-pause";
    on-click = "dbus-send --print-reply --dest=\"org.mpris.MediaPlayer2.spotifyd.instance$(pgrep spotifyd)\" /org/mpris/MediaPlayer2 \"org.mpris.MediaPlayer2.Player.PlayPause\"";
    on-scroll-up = "dbus-send --print-reply --dest=\"org.mpris.MediaPlayer2.spotifyd.instance$(pgrep spotifyd)\" /org/mpris/MediaPlayer2 \"org.mpris.MediaPlayer2.Player.Previous\"";
    on-scroll-down = "dbus-send --print-reply --dest=\"org.mpris.MediaPlayer2.spotifyd.instance$(pgrep spotifyd)\" /org/mpris/MediaPlayer2 \"org.mpris.MediaPlayer2.Player.Next\"";
  };

  home.packages = with pkgs; [
    cava
    playerctl
  ];
}
