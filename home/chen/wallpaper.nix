{ pkgs, ... }:
let
  wallDir = "~/Desktop/wallpapers";

  swww = pkgs.swww.overrideAttrs (old: rec {
    src = pkgs.fetchFromGitHub {
      owner = "Horus645";
      repo = "swww";
      rev = "0516ea09e5d7e8194d53760a71bc5bb3cd5de30b";
      hash = "sha256-HfGHkSCal2fd+/y9sk0+9sv5WAKssL2OJk/UeB5qNPw=";
    };
    RUSTFLAGS = "-C target-cpu=alderlake";
    cargoDeps = old.cargoDeps.overrideAttrs (_: {
      inherit src;
      outputHash = "sha256-YkgvlRlhl+++lsboEMWJXMBgoAM3CW00xkKgALhFDfo=";
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
