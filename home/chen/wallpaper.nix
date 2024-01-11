{ pkgs, ... }:
let
  wallDir = "~/Desktop/wallpapers";

  swww = (pkgs.swww.overrideAttrs (old: rec {
    src = pkgs.fetchFromGitHub {
      owner = "Horus645";
      repo = "swww";
      rev = "0908f36050d545a0eb97ca0cbfc40c47fc50d6ba";
      hash = "sha256-NRmlctWwiUVlbB457y3e2BpWNyJ7CHpEnAYazwYQZpk=";
    };
    RUSTFLAGS = "-C target-cpu=alderlake";
    cargoDeps = old.cargoDeps.overrideAttrs (_: {
      inherit src;
      outputHash = "sha256-z/4g2B17UvaWvVwwvHGldhTMBYapokPHs/ykHCweZ+M=";
    });
  }));

  wall = pkgs.writeScript "wall" ''
    #!${pkgs.fish}/bin/fish
    ${swww}/bin/swww-daemon &
    while true
      set pos (random 1 2000),(random 1 2000)
      set imgs (ls ${wallDir}/)
      set img (random choice ${wallDir}/$imgs)
      ${swww}/bin/swww img --transition-type grow --transition-fps 120 --filter Nearest --transition-pos $pos $img
      sleep 30
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
