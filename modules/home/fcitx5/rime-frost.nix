{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchurl,
}:
let
  rime-lmdg = fetchurl {
    url = "https://github.com/amzxyz/RIME-LMDG/releases/download/LTS/wanxiang-lts-zh-hans.gram";
    hash = "sha256-S234LD8z3IRmBfzWbGucOFT7dYGBgJOmhgJ0PG4ddaQ=";
  };
  moegirl-dict = fetchurl {
    url = "https://github.com/outloudvi/mw2fcitx/releases/download/20250409/moegirl.dict.yaml";
    hash = "sha256-/MBYX1Zb66RK6Nowky4LdMB6Vt/4n4UAxRTN0KODdwk=";
  };
  custom = ./rime_frost.custom.yaml;
  dict = ./rime_frost.combined.dict.yaml;
in
stdenv.mkDerivation rec {
  pname = "rime-frost";
  version = "0.0.5";

  src = fetchFromGitHub {
    owner = "gaboolic";
    repo = "rime-frost";
    rev = version;
    hash = "sha256-m85GZYOvO9Byhj5oq5Ts+ktd+GAIxAV5c0NtKKAXeLs=";
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
