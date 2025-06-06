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
        settings = {

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
            gaps_out = 10;
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
            explicit_sync = 2;
            explicit_sync_kms = 2;
            direct_scanout = false;
          };

          gestures = {
            workspace_swipe = true;
            workspace_swipe_fingers = 4;
            workspace_swipe_distance = 300;
            workspace_swipe_invert = true;
            workspace_swipe_min_speed_to_force = 0;
            workspace_swipe_cancel_ratio = 0.1;
          };

          layerrule = lib.mkMerge [
            (lib.mkIf config.programs.utility.rofi.enable [
              "blur, rofi"
              "ignorezero, rofi"
              "dimaround, rofi"
            ])

            (lib.mkIf config.waybar.enable [
              "noanim, waybar"
              "ignorealpha 0.1, waybar"
              "blur, waybar"
            ])

            (lib.mkIf config.dunst.enable [
              "blur, notifications"
              "ignorezero, notifications"
            ])
          ];

          windowrulev2 = lib.mkMerge [
            (lib.mkIf config.showmethekey.enable [
              "float, class:^(showmethekey-gtk)$, title:^(Floating Window - Show Me The Key)$"
              "opacity 0.5 override 0.5 override, class:^(showmethekey-gtk)$, title:^(Floating Window - Show Me The Key)$"
              "pin, class:^(showmethekey-gtk)$, title:^(Floating Window - Show Me The Key)$"
            ])

            (lib.mkIf config.pavucontrol.enable [ "float, class:^(pavucontrol-qt)$" ])
            (lib.mkIf config.neovide.enable [ "tile, class:^(neovide)$" ])
            (lib.mkIf config.wpsoffice.enable [ "tile, class:^(wpsoffice)$" ])
            (lib.mkIf config.vivaldi.enable [ "tile, class:^(Vivaldi-stable)$" ])
            (lib.mkIf config.logisim.enable [ "tile, title:^(.*Logisim-evolution v3.8.0)$" ])
            (lib.mkIf config.onlyoffice.enable [ "tile, class:^(DesktopEditors)$" ])
            (lib.mkIf config.obsidian.enable [ "opacity 0.8 override 0.8 override, class:^(obsidian)$" ])
            (lib.mkIf config.programs.im.discord.enable [
              "opacity 0.8 override 0.8 override, class:^(discord)$"
            ])
            (lib.mkIf config.vscode.enable [
              "opacity 0.8 override 0.8 override, class:^(Code)$"
              "opacity 0.8 override 0.8 override, class:^(code-url-handler)$"
            ])
            (lib.mkIf config.thunderbird.enable [ "opacity 0.8 override 0.8 override, class:^(thunderbird)$" ])
            (lib.mkIf config.programs.im.telegram.enable [
              "opacity 0.8 override 0.8 override, class:^(org.telegram.desktop)$"
            ])
            (lib.mkIf config.programs.im.qq.enable [
              "opacity 0.8 override 0.8 override, class:^(QQ)$"
              "float, class:^(QQ)$, title:^(图片查看器)$"
              "minsize 1080 0, class:^(QQ)$, title:^(QQ频道)$"
              "float, class:^(QQ)$, title:^(设置)$"
            ])

            (lib.mkIf config.terminals.kitty.enable [ "opacity 0.8 override 0.8 override, class:^(kitty)$" ])
            # (lib.mkIf config.firefox.enable [ "opacity 0.8 override 0.8 override, class:^(firefox)$" ])
            (lib.mkIf config.programs.utility.follow.enable [
              "opacity 0.8 override 0.8 override, class:^(Follow)$"
            ])
            (lib.mkIf config.programs.media.mpv.enable [ "fullscreen, class:^(mpv)$" ])
            (lib.mkIf config.programs.media.svp.enable [ "float, class:^(SVPManager)$" ])
            (lib.mkIf config.ghidra.enable [
              "nofocus,class:^ghidra-.+$,title:^win.+$,floating:1,fullscreen:0"
              "noanim,class:^ghidra-.+$,title:^win.+$,floating:1,fullscreen:0"
              "noborder,class:^ghidra-.+$,title:^win.+$,floating:1,fullscreen:0"
              "rounding 0,class:^ghidra-.+$,title:^win.+$,floating:1,fullscreen:0"
              "move onscreen cursor,class:^ghidra-.+$,title:^win.+$,floating:1,fullscreen:0"
            ])
            (lib.mkIf config.programs.utility.waydroid.enable [ "float, class:^([Ww]aydroid.*)$" ])
            [ "float, class:^(org.kde.polkit-kde-authentication-agent-1)$" ]
            [ "float, class:^(xdg-desktop-portal-gtk)$" ]
            [ "tile, class:^(pds.exe)$" ]
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
