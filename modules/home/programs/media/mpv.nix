{
  config,
  pkgs,
  lib,
  hostConfig,
  ...
}:
let
  cfg = config.programs.media.mpv;
  font = "Maple Mono NF CN";
in
{
  options.programs.media.mpv = {
    enable = lib.mkEnableOption "mpv";
    useAnime4K = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Use Anime4K shaders";
    };
  };

  config.hmConfig = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        programs.mpv = {
          enable = true;
          package = pkgs.mpv.override {
            mpv = pkgs.mpv-unwrapped.override {
              libbluray = pkgs.libbluray.override {
                withJava = true;
                withAACS = true;
              };
            };
            scripts = [ pkgs.mpvScripts.mpris ];
          };
          bindings = {
            MBTN_LEFT = "cycle pause";

            WHEEL_UP = "add volume 2";
            WHEEL_DOWN = "add volume -2";

            UP = "add volume 2";
            DOWN = "add volume -2";

            LEFT = "seek -1";
            RIGHT = "seek 1";
          };

          config = {

            # https://vcb-s.com/archives/7594
            profile = "high-quality";
            cscale = "catmull_rom";
            deband = true;
            blend-subtitles = "video";
            fullscreen = true;

            vo = "gpu";

            hwdec = "vaapi";
            hwdec-codecs = "all";

            # font of on screen display
            osd-font = font;

            sub-auto = "fuzzy";
            sub-font = font;
            sub-bold = true;
          };
        };

        xdg.mimeApps.defaultApplications = lib.genAttrs [
          "audio/mpeg"
          "audio/x-wav"
        ] (mime: "mpv.desktop");
      }

      (lib.mkIf (hostConfig.nvidia.enable && cfg.useAnime4K) {
        xdg.configFile."mpv/shaders" = {
          source =
            pkgs.fetchzip {
              url = "https://github.com/Tama47/Anime4K/releases/latest/download/GLSL_Mac_Linux_High-end.zip";
              hash = "sha256-Ah9fnVCDsliUzbCkKFcnWjLqG0y5DYlXJkZAz/H/oLQ=";
              stripRoot = false;
            }
            + "/shaders";
          recursive = true;
        };

        programs.mpv = {
          bindings = {
            "CTRL+1" =
              "no-osd change-list glsl-shaders set \"~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_VL.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_VL.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl\"; show-text \"Anime4K: Mode A (HQ)\"";
            "CTRL+2" =
              "no-osd change-list glsl-shaders set \"~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_Soft_VL.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_VL.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl\"; show-text \"Anime4K: Mode B (HQ)\"";
            "CTRL+3" =
              "no-osd change-list glsl-shaders set \"~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Upscale_Denoise_CNN_x2_VL.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl\"; show-text \"Anime4K: Mode C (HQ)\"";
            "CTRL+4" =
              "no-osd change-list glsl-shaders set \"~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_VL.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_VL.glsl:~~/shaders/Anime4K_Restore_CNN_M.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl\"; show-text \"Anime4K: Mode A+A (HQ)\"";
            "CTRL+5" =
              "no-osd change-list glsl-shaders set \"~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_Soft_VL.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_VL.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Restore_CNN_Soft_M.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl\"; show-text \"Anime4K: Mode B+B (HQ)\"";
            "CTRL+6" =
              "no-osd change-list glsl-shaders set \"~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Upscale_Denoise_CNN_x2_VL.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Restore_CNN_M.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl\"; show-text \"Anime4K: Mode C+A (HQ)\"";
            "CTRL+0" = "no-osd change-list glsl-shaders clr \"\"; show-text \"GLSL shaders cleared\"";
          };

          # config.glsl-shaders = "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_VL.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_VL.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl";
        };
      })
    ]
  );
}
