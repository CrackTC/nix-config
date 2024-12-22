{ lib
, stdenv
, fetchFromGitHub
, fetchurl
}:
let
  rime-lmdg = fetchurl {
    url = "https://github.com/amzxyz/RIME-LMDG/releases/download/v3n2/amz-v3n2m1-zh-hans.gram";
    hash = "sha256-9QUGaYJl6l+rQVdS26tdPw+HgV+deGCo8ESpJjSKhF8=";
  };
  custom = ./rime_frost.custom.yaml;
in
stdenv.mkDerivation rec {
  pname = "rime-frost";
  version = "0.0.4.1";

  src = fetchFromGitHub {
    owner = "gaboolic";
    repo = "rime-frost";
    rev = version;
    hash = "sha256-WZcBxh195izM7d2GUrRSGuoXDR09WtdDQL7TcNXJ7Oc=";
  };

  installPhase = ''
    mkdir -p $out/share/rime-data
    mv * $out/share/rime-data
    cp ${rime-lmdg} $out/share/rime-data/amz-v3n2m1-zh-hans.gram
    cp ${custom} $out/share/rime-data/rime_frost.custom.yaml
  '';

  meta = with lib; {
    homepage = "https://github.com/gaboolic/rime-frost";
    license = licenses.gpl3Only;
  };
}
