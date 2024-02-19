{ pkgs, ... }:
let
  wallDir = "~/Desktop/wallpapers";

  swww = pkgs.swww.overrideAttrs (old: rec {
    src = pkgs.fetchFromGitHub {
      owner = "Horus645";
      repo = "swww";
      rev = "a3dc064fab7db2ae5ed282b4e4ee7c68f2d2854a";
      hash = "sha256-JoXnwKjmtv+1PUSrriNAEoTONrNeJ5cR9KJ6qPy4Go4=";
    };
    RUSTFLAGS = "-C target-cpu=alderlake";
    cargoDeps = old.cargoDeps.overrideAttrs (_: {
      inherit src;
      outputHash = "sha256-IIrMgdjbGviQdwlU2E6ujjb8ULpVXsMvntcQvdv7UOo=";
    });
  });

  wall = pkgs.writeScript "wall" ''
    #!${pkgs.fish}/bin/fish
    ${swww}/bin/swww-daemon &
    while true
      set pos (random 1 2000),(random 1 2000)
      set imgs (ls ${wallDir}/)
      set img (random choice ${wallDir}/$imgs)
      ${swww}/bin/swww img --transition-type grow --transition-fps 120 --filter Nearest --transition-pos $pos $img
      sleep 600
    end
  '';
in
{
  systemd.user.services = {
    wall = {
      Unit = {
        Description = "wallpaper daemon";
      };

      Service = {
        ExecStart = "${wall}";
        Restart = "always";
      };

      Install = {
        WantedBy = [ "hyprland-session.target" ];
      };
    };
  };
}
