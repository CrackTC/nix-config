{
  stdenv,
  fetchzip,
}:
let
  src = fetchzip {
    url = "https://hyperos.mi.com/font-download/MiSans.zip";
    hash = "sha256-MH4t7oXDUiH1TAm0xKa0AENmB1zoedd8X5BcQFNw8GM=";
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
