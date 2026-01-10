{
  stdenv,
  fetchzip,
}:
let
  src = fetchzip {
    url = "https://hyperos.mi.com/font-download/MiSans.zip";
    hash = "sha256-497H20SYzzUFaUHkqUkYlROLrqXRBLkBkylsRqZ6KfM=";
    stripRoot = false;
  };
in
stdenv.mkDerivation {
  name = "misans";
  version = "1.0";
  inherit src;

  installPhase = ''
    mkdir -p $out/share/fonts
    cp -r $src/* $out/share/fonts
  '';
}
