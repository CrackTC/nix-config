{ config, lib, ... }:
let cfg = config.editors.nvim; in {
  options.editors.nvim = {
    enable = lib.mkEnableOption "nvim";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    xdg.configFile = {
      "nvim/init.lua".source = ./config/init.lua;
      "nvim/lua" = {
        source = ./config/lua;
        recursive = true;
      };
    };

    xdg.mimeApps.defaultApplications =
      lib.genAttrs [
        "text/english"
        "text/plain"
        "text/x-makefile"
        "text/x-c++hdr"
        "text/x-c++src"
        "text/x-chdr"
        "text/x-csrc"
        "text/x-java"
        "text/x-moc"
        "text/x-pascal"
        "text/x-tcl"
        "text/x-tex"
        "application/x-shellscript"
        "text/x-c"
        "text/x-c++"
        "application/xml"
      ]
        (mime: "nvim.desktop");

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      withPython3 = true;
    };
  };
}
