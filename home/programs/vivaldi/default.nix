{ pkgs, ... }: {
  home.file.".local/share/vivaldi/custom" = {
    source = ./custom;
    recursive = true;
  };

  home.packages = with pkgs; [
    (vivaldi.override {
      proprietaryCodecs = true;
      enableWidevine = true;
    })
    vivaldi-ffmpeg-codecs
  ];
}
