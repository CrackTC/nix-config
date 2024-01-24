{ pkgs, ... }:
let
  font = "Maple Mono SC NF";
  shaders = pkgs.fetchzip
    {
      url = "https://github.com/Tama47/Anime4K/releases/latest/download/GLSL_Mac_Linux_High-end.zip";
      hash = "sha256-Ah9fnVCDsliUzbCkKFcnWjLqG0y5DYlXJkZAz/H/oLQ=";
      stripRoot = false;
    } + "/shaders";
in
{
  programs.mpv = {
    enable = true;
    bindings = {
      MBTN_LEFT = "cycle pause";

      WHEEL_UP = "add volume 2";
      WHEEL_DOWN = "add volume -2";

      UP = "add volume 2";
      DOWN = "add volume -2";

      "CTRL+1" = "no-osd change-list glsl-shaders set \"~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_VL.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_VL.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl\"; show-text \"Anime4K: Mode A (HQ)\"";

      "CTRL+2" = "no-osd change-list glsl-shaders set \"~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_Soft_VL.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_VL.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl\"; show-text \"Anime4K: Mode B (HQ)\"";

      "CTRL+3" = "no-osd change-list glsl-shaders set \"~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Upscale_Denoise_CNN_x2_VL.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl\"; show-text \"Anime4K: Mode C (HQ)\"";

      "CTRL+4" = "no-osd change-list glsl-shaders set \"~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_VL.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_VL.glsl:~~/shaders/Anime4K_Restore_CNN_M.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl\"; show-text \"Anime4K: Mode A+A (HQ)\"";

      "CTRL+5" = "no-osd change-list glsl-shaders set \"~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_Soft_VL.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_VL.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Restore_CNN_Soft_M.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl\"; show-text \"Anime4K: Mode B+B (HQ)\"";

      "CTRL+6" = "no-osd change-list glsl-shaders set \"~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Upscale_Denoise_CNN_x2_VL.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Restore_CNN_M.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl\"; show-text \"Anime4K: Mode C+A (HQ)\"";

      "CTRL+0" = "no-osd change-list glsl-shaders clr \"\"; show-text \"GLSL shaders cleared\"";
    };

    config = {
      # full screen on startup
      fs = true;

      vo = "gpu";
      gpu-api = "vulkan";
      hwdec-codecs = "all";

      # font of on screen display
      osd-font = font;

      sub-auto = "fuzzy";
      sub-font = font;
      sub-bold = true;

      # Anime4K
      glsl-shaders = "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_VL.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_VL.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl";
    };
  };

  xdg.configFile."mpv/shaders" = {
    source = shaders;
    recursive = true;
  };
}
