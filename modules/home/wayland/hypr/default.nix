{
  config,
  pkgs,
  lib,
  # extraRepos,
  name,
  ...
}:
let
  cfg = config.hypr;
  mkEnv =
    name: value:
    # lua
    ''
      hl.env("${name}", "${value}")
    '';
  mkExec =
    cmd:
    # lua
    ''
      hl.exec_cmd("${lib.replaceStrings [ ''"'' ] [ ''\"'' ] cmd}")
    '';
in
{
  imports = [
    ./nvidia.nix
    ./intel.nix
    ./ext.nix
    ./keybindings.nix
  ];

  options.hypr = {
    enable = lib.mkEnableOption "hyprland";
    useNvidia = lib.mkEnableOption "hyprland nvidia settings";
  };

  config = lib.mkIf cfg.enable {
    wayland.enable = true;
    wl-clipboard.enable = true;
    hmConfig = {
      wayland.windowManager.hyprland = {
        enable = true;
        # package = extraRepos.hyprland.hyprland;
        package = pkgs.hyprland;
        portalPackage = null;
        configType = "lua";
        extraConfig =
          let
            gapsOut = 10;
          in
          lib.mkMerge [
            (mkEnv "LANG" "zh_CN.UTF-8")
            (mkEnv "LANGUAGE" "zh_CN:en_US")

            # Toolkit Backend Variables
            (mkEnv "GDK_BACKEND" "wayland,x11,*")
            (mkEnv "QT_QPA_PLATFORM" "wayland;xcb")
            (mkEnv "SDL_VIDEODRIVER" "wayland")
            (mkEnv "CLUTTER_BACKEND" "wayland")

            # XDG Specifications
            (mkEnv "XDG_CURRENT_DESKTOP" "Hyprland")
            (mkEnv "XDG_SESSION_TYPE" "wayland")
            (mkEnv "XDG_SESSION_DESKTOP" "Hyprland")

            # QT Variables
            (mkEnv "QT_AUTO_SCREEN_SCALE_FACTOR" "1")
            (mkEnv "QT_WAYLAND_DISABLE_WINDOWDECORATION" "1")

            # GTK Variables
            # (mkEnv "GTK_USE_PORTAL" "1")

            (mkEnv "XDG_CONFIG_HOME" "/home/${name}/.config")
            (mkEnv "XDG_CONFIG_DIR" "/home/${name}/.config")

            (mkEnv "GDK_SCALE" "2")
            (mkEnv "XCURSOR_SIZE" "32")

            (lib.mkIf config.firefox.enable ''
              ${mkEnv "MOZ_ENABLE_WAYLAND" "1"}
              ${mkEnv "MOZ_WEBRENDER" "1"}
            '')
            (lib.mkIf config.node.enable "${mkEnv "NODE_PATH" "/home/${name}/.local/lib/nodejs/node_modules"}")
            (lib.mkIf config.java.enable "${mkEnv "_JAVA_OPTIONS" "-Dawt.useSystemAAFontSettings=lcd"}")

            # lua
            ''
              hl.on("hyprland.start", function ()
                ${mkExec "${lib.getExe pkgs.swaybg} -i /home/${name}/Desktop/wallpaper"}
                ${if config.fcitx5.enable then mkExec "fcitx5 -d" else ""}
                ${if config.go.enable then mkExec "go env -w GOPROXY=https://goproxy.cn,direct" else ""}
                ${if config.imwheel.enable then mkExec "imwheel" else ""}
                ${if config.waybar.enable then mkExec "waybar" else ""}
                ${if config.programs.utility.ydotool.enable then mkExec "ydotoold" else ""}
                ${
                  if config.terminal.preferred == "ghostty" then
                    mkExec "ghostty --gtk-single-instance=true --quit-after-last-window-closed=false --initial-window=false"
                  else
                    ""
                }
              end)
            ''

            # lua
            ''
              hl.config({
                input = {
                  kb_layout = "us",
                  ${
                    if config.colemak.enable then
                      # lua
                      ''kb_variant = "colemak"''
                    else
                      ""
                  },
                  kb_options = "caps:swapescape",

                  accel_profile = "adaptive",
                  repeat_delay = 200,

                  follow_mouse = 1,

                  touchpad = {
                    natural_scroll = true,
                  };

                  sensitivity = 0,
                },

                cursor = {
                  no_hardware_cursors = 0,
                },

                general = {
                  gaps_in = 5,
                  gaps_out = ${toString gapsOut},
                  layout = "dwindle",
                  snap = {
                    enabled = true,
                  },
                },

                decoration = {
                  rounding = 13,

                  blur = {
                    enabled = true,
                    size = 5,
                    passes = 4,
                    new_optimizations = true,
                    ignore_opacity = true,
                    popups = true,
                    popups_ignorealpha = 0.8,
                  },
                },

                animations = {
                  enabled = true,
                },

                dwindle = {
                  preserve_split = true,
                },

                misc = {
                  vrr = false,
                  animate_manual_resizes = false,
                  animate_mouse_windowdragging = false,
                  disable_autoreload = true,
                  focus_on_activate = false,
                  disable_hyprland_logo = true,
                },

                render = {
                  direct_scanout = false,
                },

                gestures = {
                  workspace_swipe_distance = 300,
                  workspace_swipe_invert = true,
                  workspace_swipe_min_speed_to_force = 0,
                  workspace_swipe_cancel_ratio = 0.1,
                },

                xwayland = {
                  use_nearest_neighbor = false,
                  force_zero_scaling = true,
                },
              })

              hl.gesture({
                fingers = 4,
                direction = "horizontal",
                action = "workspace",
              })

              hl.curve("myBezier", {
                type = "bezier",
                points = {
                  { 0.05, 0.9 },
                  { 0.1, 1.05 }
                }
              })

              hl.animation({
                leaf = "windows",
                enabled = true,
                speed = 6,
                bezier = "myBezier",
              })

              hl.animation({
                leaf = "windowsOut",
                enabled = true,
                speed = 6,
                bezier = "default",
                style = "popin 30%",
              })

              hl.animation({
                leaf = "border",
                enabled = true,
                speed = 10,
                bezier = "default",
              })

              hl.animation({
                leaf = "fade",
                enabled = true,
                speed = 7,
                bezier = "default",
              })

              hl.animation({
                leaf = "fadeIn",
                enabled = true,
                speed = 7,
                bezier = "default",
              })

              hl.animation({
                leaf = "fadeOut",
                enabled = true,
                speed = 3,
                bezier = "default",
              })

              hl.animation({
                leaf = "workspaces",
                enabled = true,
                speed = 6,
                bezier = "default",
              })
            ''

            (lib.mkIf config.programs.utility.ydotool.enable
              # lua
              ''
                hl.device({
                  name = "ydotoold-virtual-device",
                  kb_layout = "us",
                  kb_variant = "",
                  kb_options = "",
                  keybinds = false,
                })
              ''
            )

            (lib.mkIf config.programs.utility.rofi.enable
              # lua
              ''
                hl.layer_rule({
                  match = { namespace = "rofi" },
                  blur = true,
                  ignore_alpha = 0,
                  dim_around = true,
                })
              ''
            )

            (lib.mkIf config.waybar.enable
              # lua
              ''
                hl.layer_rule({
                  match = { namespace = "waybar" },
                  ignore_alpha = 0.1,
                  blur = true,
                })
              ''
            )

            (lib.mkIf config.dunst.enable
              # lua
              ''
                hl.layer_rule({
                  match = { namespace = "notifications" },
                  blur = true,
                  ignore_alpha = 0,
                })
              ''
            )

            (lib.mkIf config.showmethekey.enable
              # lua
              ''
                hl.window_rule({
                  match = { class = "showmethekey-gtk", title = "Floating Window - Show Me The Key" },
                  float = true,
                  opacity = "0.5 override 0.5 override",
                  pin = true,
                })
              ''
            )

            (lib.mkIf config.pavucontrol.enable
              # lua
              ''
                hl.window_rule({
                  match = { class = "pavucontrol-qt" },
                  float = true,
                })
              ''
            )

            (lib.mkIf config.neovide.enable
              # lua
              ''
                hl.window_rule({
                  match = { class = "neovide" },
                  tile = true,
                })
              ''
            )

            (lib.mkIf config.wpsoffice.enable
              # lua
              ''
                hl.window_rule({
                  match = { class = "wpsoffice" },
                  tile = true,
                })
              ''
            )

            (lib.mkIf config.vivaldi.enable
              # lua
              ''
                hl.window_rule({
                  match = { class = "Vivaldi-stable" },
                  tile = true,
                })
              ''
            )

            (lib.mkIf config.logisim.enable
              # lua
              ''
                hl.window_rule({
                  match = { title = ".*Logisim-evolution v3.8.0" },
                  tile = true,
                })
              ''
            )

            (lib.mkIf config.onlyoffice.enable
              # lua
              ''
                hl.window_rule({
                  match = { class = "DesktopEditors" },
                  tile = true,
                })
              ''
            )

            (lib.mkIf config.obsidian.enable
              # lua
              ''
                hl.window_rule({
                  match = { class = "obsidian" },
                  opacity = "0.8 override 0.8 override",
                })
              ''
            )

            (lib.mkIf config.programs.im.discord.enable
              # lua
              ''
                hl.window_rule({
                  match = { class = "discord" },
                  opacity = "0.8 override 0.8 override",
                })
              ''
            )

            (lib.mkIf config.vscode.enable
              # lua
              ''
                hl.window_rule({
                  match = { class = "Code|code-url-handler" },
                  opacity = "0.8 override 0.8 override",
                })
              ''
            )

            (lib.mkIf config.thunderbird.enable
              # lua
              ''
                hl.window_rule({
                  match = { class = "thunderbird" },
                  opacity = "0.8 override 0.8 override",
                })
              ''
            )

            (lib.mkIf config.programs.im.telegram.enable
              # lua
              ''
                hl.window_rule({
                  match = { class = "org.telegram.desktop" },
                  opacity = "0.8 override 0.8 override",
                })
              ''
            )

            (lib.mkIf config.programs.im.qq.enable
              # lua
              ''
                hl.window_rule({
                  match = { class = "QQ" },
                  opacity = "0.8 override 0.8 override",
                })

                hl.window_rule({
                  match = { class = "QQ", title = "图片查看器|设置|.*的聊天记录" },
                  float = true,
                })

                hl.window_rule({
                  match = { class = "QQ", title = "QQ频道" },
                  min_size = { 1080, 0 },
                })

                hl.window_rule({
                  match = { class = "QQ", title = "资料卡|天气" },
                  move = { "cursor_x", "cursor_y" },
                })
              ''
            )

            (lib.mkIf config.terminals.kitty.enable
              # lua
              ''
                hl.window_rule({
                  match = { class = "kitty" },
                  opacity = "0.8 override 0.8 override",
                })
              ''
            )

            (lib.mkIf config.firefox.enable
              # lua
              ''
                hl.window_rule({
                  match = { class = "firefox", title = "Picture-in-Picture" },
                  float = true,
                  move = { "${toString gapsOut}", "monitor_h-window_h-${toString gapsOut}" },
                  no_initial_focus = true,
                })
              ''
            )

            (lib.mkIf config.programs.utility.follow.enable
              # lua
              ''
                hl.window_rule({
                  match = { class = "Follow" },
                  opacity = "0.8 override 0.8 override",
                })
              ''
            )

            (lib.mkIf config.programs.media.mpv.enable
              # lua
              ''
                hl.window_rule({
                  match = { class = "mpv" },
                  fullscreen = true,
                })
              ''
            )

            (lib.mkIf config.programs.media.svp.enable
              # lua
              ''
                hl.window_rule({
                  match = { class = "SVPManager" },
                  float = true,
                })
              ''
            )

            (lib.mkIf config.ghidra.enable
              # lua
              ''
                hl.window_rule({
                  match = { class = "ghidra-.+", title = "win.+", float = true, fullscreen = false },
                  no_focus = true,
                  no_anim = true,
                  border_size = 0,
                  rounding = 0,
                  move = { "cursor_x", "cursor_y" },
                })
              ''
            )

            (lib.mkIf config.programs.utility.waydroid.enable
              # lua
              ''
                hl.window_rule({
                  match = { class = "[Ww]aydroid.*" },
                  float = true,
                })
              ''
            )

            (lib.mkIf config.programs.utility.aegisub.enable
              # lua
              ''
                hl.window_rule({
                  match = { class = "aegisub" },
                  rounding = 0,
                })
              ''
            )

            (lib.mkIf config.programs.media.vlc.enable
              # lua
              ''
                hl.window_rule({
                  match = { class = "vlc" },
                  rounding = 0,
                })

                hl.window_rule({
                  match = { class = "vlc", title = "vlc", xwayland = true, float = true },
                  no_anim = true,
                  no_blur = true,
                })

                hl.window_rule({
                  match = { class = "vlc", title = "vlc", xwayland = false, float = true },
                  move = "monitor_w-window_w monitor_h-window_h",
                  no_anim = true,
                })
              ''
            )

            # lua
            ''
              hl.window_rule({
                match = { xwayland = true },
                rounding = 0,
                no_anim = true,
                no_blur = true,
              })

              hl.window_rule({
                match = { class = "org.kde.polkit-kde-authentication-agent-1" },
                float = true,
              })

              hl.window_rule({
                match = { class = "xdg-desktop-portal-gtk" },
                float = true,
              })
            ''
          ];
      };
    };
  };
}
