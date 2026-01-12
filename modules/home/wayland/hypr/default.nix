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
        settings =
          let
            gaps_out = 10;
          in
          {

            env = lib.mkMerge [
              [
                "LANG,zh_CN.UTF-8"
                "LANGUAGE,zh_CN:en_US"

                # Toolkit Backend Variables
                "GDK_BACKEND,wayland,x11,*"
                "QT_QPA_PLATFORM,wayland;xcb"
                "SDL_VIDEODRIVER,wayland"
                "CLUTTER_BACKEND,wayland"

                # XDG Specifications
                "XDG_CURRENT_DESKTOP,Hyprland"
                "XDG_SESSION_TYPE,wayland"
                "XDG_SESSION_DESKTOP,Hyprland"

                # QT Variables
                "QT_AUTO_SCREEN_SCALE_FACTOR,1"
                "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"

                # GTK Variables
                # "GTK_USE_PORTAL,1"

                "XDG_CONFIG_HOME,/home/${name}/.config"
                "XDG_CONFIG_DIR,/home/${name}/.config"

                "GDK_SCALE,2"
                "XCURSOR_SIZE,32"
              ]
              (lib.mkIf config.firefox.enable [
                "MOZ_ENABLE_WAYLAND,1"
                "MOZ_WEBRENDER,1"
              ])
              (lib.mkIf config.node.enable [ "NODE_PATH,/home/${name}/.local/lib/nodejs/node_modules" ])
              (lib.mkIf config.java.enable [ "_JAVA_OPTIONS,'-Dawt.useSystemAAFontSettings=lcd'" ])
            ];

            exec-once = lib.mkMerge [
              [
                "${lib.getExe pkgs.swaybg} -i /home/${name}/Desktop/wallpaper"
              ]
              (lib.mkIf config.fcitx5.enable [ "fcitx5 -d" ])
              (lib.mkIf config.go.enable [ "go env -w GOPROXY=https://goproxy.cn,direct" ])
              (lib.mkIf config.imwheel.enable [ "imwheel" ])
              (lib.mkIf config.waybar.enable [ "waybar" ])
              (lib.mkIf config.programs.utility.ydotool.enable [ "ydotoold" ])
              (lib.mkIf (config.terminal.preferred == "ghostty") [
                "ghostty --gtk-single-instance=true --quit-after-last-window-closed=false --initial-window=false"
              ])
            ];

            input = {
              kb_layout = "us";
              kb_variant = lib.mkIf config.colemak.enable "colemak";
              kb_options = "caps:swapescape";

              accel_profile = "adaptive";
              repeat_delay = 200;

              follow_mouse = 1;

              touchpad = {
                natural_scroll = true;
              };

              sensitivity = 0;
            };

            cursor = {
              no_hardware_cursors = 0;
            };

            device = lib.mkIf config.programs.utility.ydotool.enable {
              name = "ydotoold-virtual-device";
              kb_layout = "us";
              kb_variant = "";
              kb_options = "";
            };

            general = {
              gaps_in = 5;
              inherit gaps_out;
              # border_size = 2;
              # "col.active_border" = "rgba(88c0d0ff)";
              # "col.inactive_border" = "rgba(4c566aff)";

              layout = "dwindle";

              snap.enabled = true;
            };

            decoration = {
              rounding = 13;

              blur = {
                enabled = true;
                size = 5;
                passes = 4;
                new_optimizations = true;
                ignore_opacity = true;
                popups = true;
                popups_ignorealpha = 0.8;
              };

              # drop_shadow = false;
              # shadow_range = 20;
              # "col.shadow_inactive" = "rgba(00000000)";
            };

            animations = {
              enabled = true;

              bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
              animation = [
                "windows, 1, 6, myBezier"
                "windowsOut, 1, 6, default, popin 30%"
                "border, 1, 10, default"
                "borderangle, 1, 8, default"
                "fade, 1, 7, default"
                "fadeIn, 1, 7, default"
                "fadeOut, 1, 3, default"
                "workspaces, 1, 6, default"
              ];
            };

            dwindle = {
              pseudotile = true;
              preserve_split = true;
            };

            misc = {
              vfr = true;
              vrr = false;
              animate_manual_resizes = false;
              animate_mouse_windowdragging = false;
              disable_autoreload = true;
              focus_on_activate = false;
              disable_hyprland_logo = true;
            };

            render = {
              direct_scanout = false;
            };

            gestures = {
              workspace_swipe_distance = 300;
              workspace_swipe_invert = true;
              workspace_swipe_min_speed_to_force = 0;
              workspace_swipe_cancel_ratio = 0.1;
            };

            gesture = [
              "4, horizontal, workspace"
            ];

            layerrule = [
              (lib.mkIf config.programs.utility.rofi.enable rec {
                name = "rofi";
                "match:namespace" = name;
                blur = true;
                ignore_alpha = 0;
                dim_around = true;
              })
              (lib.mkIf config.waybar.enable rec {
                name = "waybar";
                "match:namespace" = name;
                ignore_alpha = 0.1;
                blur = true;
              })
              (lib.mkIf config.dunst.enable rec {
                name = "notifications";
                "match:namespace" = name;
                blur = true;
                ignore_alpha = 0;
              })
            ];

            windowrule = [
              (lib.mkIf config.showmethekey.enable {
                name = "showmethekey";
                "match:class" = "showmethekey-gtk";
                "match:title" = "Floating Window - Show Me The Key";
                float = true;
                opacity = "0.5 override 0.5 override";
                pin = true;
              })

              (lib.mkIf config.pavucontrol.enable {
                name = "pavucontrol";
                "match:class" = "pavucontrol-qt";
                float = true;
              })

              (lib.mkIf config.neovide.enable {
                name = "neovide";
                "match:class" = "neovide";
                tile = true;
              })

              (lib.mkIf config.wpsoffice.enable {
                name = "wpsoffice";
                "match:class" = "wpsoffice";
                tile = true;
              })

              (lib.mkIf config.vivaldi.enable {
                name = "vivaldi";
                "match:class" = "Vivaldi-stable";
                tile = true;
              })

              (lib.mkIf config.logisim.enable {
                name = "logisim";
                "match:title" = ".*Logisim-evolution v3.8.0";
                tile = true;
              })

              (lib.mkIf config.onlyoffice.enable {
                name = "onlyoffice";
                "match:class" = "DesktopEditors";
                tile = true;
              })

              (lib.mkIf config.obsidian.enable {
                name = "obsidian";
                "match:class" = "obsidian";
                opacity = "0.8 override 0.8 override";
              })

              (lib.mkIf config.programs.im.discord.enable {
                name = "discord";
                "match:class" = "discord";
                opacity = "0.8 override 0.8 override";
              })

              (lib.mkIf config.vscode.enable {
                name = "vscode";
                "match:class" = "Code|code-url-handler";
                opacity = "0.8 override 0.8 override";
              })

              (lib.mkIf config.thunderbird.enable {
                name = "thunderbird";
                "match:class" = "thunderbird";
                opacity = "0.8 override 0.8 override";
              })

              (lib.mkIf config.programs.im.telegram.enable {
                name = "telegram";
                "match:class" = "org.telegram.desktop";
                opacity = "0.8 override 0.8 override";
              })

              (lib.mkIf config.programs.im.qq.enable {
                name = "qq-opacity";
                "match:class" = "QQ";
                opacity = "0.8 override 0.8 override";
              })

              (lib.mkIf config.programs.im.qq.enable {
                name = "qq-float";
                "match:class" = "QQ";
                "match:title" = "图片查看器|设置|.*的聊天记录";
                float = true;
              })

              (lib.mkIf config.programs.im.qq.enable {
                name = "qq-minsize";
                "match:class" = "QQ";
                "match:title" = "QQ频道";
                min_size = "1080 0";
              })

              (lib.mkIf config.programs.im.qq.enable {
                name = "qq-move-cursor";
                "match:class" = "QQ";
                "match:title" = "资料卡|天气";
                move = "cursor_x cursor_y";
              })

              (lib.mkIf config.terminals.kitty.enable {
                name = "kitty";
                "match:class" = "kitty";
                opacity = "0.8 override 0.8 override";
              })

              (lib.mkIf config.firefox.enable {
                name = "firefox-pip";
                "match:class" = "firefox";
                "match:title" = "Picture-in-Picture";
                float = true;
                move = "${toString gaps_out} monitor_h-window_h-${toString gaps_out}";
                no_initial_focus = true;
              })

              (lib.mkIf config.programs.utility.follow.enable {
                name = "follow";
                "match:class" = "Follow";
                opacity = "0.8 override 0.8 override";
              })

              (lib.mkIf config.programs.media.mpv.enable {
                name = "mpv";
                "match:class" = "mpv";
                fullscreen = true;
              })

              (lib.mkIf config.programs.media.svp.enable {
                name = "svpmanager";
                "match:class" = "SVPManager";
                float = true;
              })

              (lib.mkIf config.ghidra.enable {
                name = "ghidra";
                "match:class" = "ghidra-.+";
                "match:title" = "win.+";
                "match:float" = true;
                "match:fullscreen" = false;
                no_focus = true;
                no_anim = true;
                border_size = 0;
                rounding = 0;
                move = "cursor_x cursor_y";
              })

              (lib.mkIf config.programs.utility.waydroid.enable {
                name = "waydroid";
                "match:class" = "[Ww]aydroid.*";
                float = true;
              })

              (lib.mkIf config.programs.utility.aegisub.enable {
                name = "aegisub";
                "match:class" = "aegisub";
                rounding = 0;
              })

              (lib.mkIf config.programs.media.vlc.enable {
                name = "vlc-no-rounding";
                "match:class" = "vlc";
                rounding = 0;
              })

              (lib.mkIf config.programs.media.vlc.enable {
                name = "vlc-xwayland-fix";
                "match:class" = "vlc";
                "match:title" = "vlc";
                "match:xwayland" = true;
                "match:float" = true;
                no_anim = true;
                no_blur = true;
              })

              (lib.mkIf config.programs.media.vlc.enable {
                name = "vlc-wayland-fix";
                "match:class" = "vlc";
                "match:title" = "vlc";
                "match:xwayland" = false;
                "match:float" = true;
                no_anim = true;
                move = "monitor_w-window_w monitor_h-window_h";
              })

              {
                name = "polkit";
                "match:class" = "org.kde.polkit-kde-authentication-agent-1";
                float = true;
              }

              {
                name = "xdg-desktop-portal-gtk";
                "match:class" = "xdg-desktop-portal-gtk";
                float = true;
              }
            ];

            xwayland = {
              use_nearest_neighbor = false;
              force_zero_scaling = true;
            };
          };
      };
    };
  };
}
