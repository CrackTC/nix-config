{ lib
, stdenv
, fetchFromGitHub
, fetchurl
}:
let
  rime-lmdg = fetchurl {
    url = "https://github.com/amzxyz/RIME-LMDG/releases/download/LTS/wanxiang-lts-zh-hans.gram";
    hash = "sha256-PZLmGnyogMXSFAmjEtslDtCxYkqiGmPE+VLGgYwXAO0=";
  };
  moegirl-dict = fetchurl {
    url = "https://github.com/outloudvi/mw2fcitx/releases/download/20241211/moegirl.dict.yaml";
    hash = "sha256-mAa2seIqBzEgIwMokfU3lyA/GwwDVBvjXax3i2l+qm8=";
  };
  custom = ./rime_frost.custom.yaml;
  dict = ./rime_frost.combined.dict.yaml;
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
    cp ${rime-lmdg} $out/share/rime-data/wanxiang-lts-zh-hans.gram
    cp ${custom} $out/share/rime-data/rime_frost.custom.yaml
    cp ${dict} $out/share/rime-data/rime_frost.combined.dict.yaml
    cp ${moegirl-dict} $out/share/rime-data/moegirl.dict.yaml
  '';

  meta = with lib; {
    homepage = "https://github.com/gaboolic/rime-frost";
    license = licenses.gpl3Only;
  };
}
