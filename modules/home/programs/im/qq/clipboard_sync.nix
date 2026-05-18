# https://github.com/huanghunr/nixos-config/blob/91d13f50b8935fae2c10aac4998123517257f214/home/script/clipboard_sync.nix
{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  pname = "clipboard_sync";
  version = "1.0.0";

  src = ./.;

  nativeBuildInputs = [ pkgs.makeWrapper ];

  buildInputs = [ pkgs.xclip ];

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp clipboard_sync.sh $out/bin/clipboard_sync
    chmod +x $out/bin/clipboard_sync

    wrapProgram $out/bin/clipboard_sync \
      --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.xclip ]}
  '';
}
