{ useNvidia, extMonitor }: { pkgs, lib, extraRepos, info, ... }: {
  imports =
    (lib.singleton (if useNvidia then ./nvidia.nix else ./intel.nix))
    ++ (lib.optional (!extMonitor) ./noExtMonitor.nix)
    ++ (lib.singleton ./keybindings.nix);
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = lib.mkDefault [
        # "DP-1,2560x1440@170,auto,1"
        "eDP-1,2560x1440@240,0x0,1"
        # "HDMI-A-1,disabled"
      ];

      # workspace = lib.mkDefault [
      #   "1, monitor:DP-1"
      #   "2, monitor:DP-1"
      #   "3, monitor:DP-1"
      #   "4, monitor:DP-1"
      #   "5, monitor:DP-1"
      #   "6, monitor:DP-1"
      #   "7, monitor:DP-1"
      #   "8, monitor:DP-1"
      #   "9, monitor:eDP-1"
      #   "10, monitor:eDP-1, default:true"
      # ];

      env = [
        "LANG,zh_CN.UTF-8"
        "LANGUAGE,zh_CN:en_US"

        "QT_QPA_PLATFORM,wayland"
        "CLUTTER_BACKEND,wayland"
        "SDL_VIDEODRIVER,wayland"
        "XDG_CURRENT_DESKTOP,Hyprland"

        "MOZ_ENABLE_WAYLAND,1"
        "MOZ_WEBRENDER,1"

        "GDK_BACKEND,wayland,x11"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XDG_CONFIG_HOME,/home/${info.username}/.config"
        "XDG_CONFIG_DIR,/home/${info.username}/.config"

        # paths
        "NODE_PATH,/home/${info.username}/.local/lib/nodejs/node_modules"

        # java font anti-alias
        "_JAVA_OPTIONS,'-Dawt.useSystemAAFontSettings=lcd'"
      ];

      exec-once = [
        "fcitx5 -d"
        "go env -w GOPROXY=https://goproxy.cn,direct"
        "hyprctl setcursor 'Capitaine Cursors (Nord)' 24"
        "imwheel"
        "waybar"
        "${pkgs.wl-clip-persist}/bin/wl-clip-persist --clipboard regular"
        "ydotoold"
        "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1"
      ];

      input = {
        kb_layout = "us";
        kb_variant = "colemak";
        kb_options = "caps:swapescape";

        accel_profile = "adaptive";
        repeat_delay = 200;

        follow_mouse = 1;

        touchpad = {
          natural_scroll = true;
        };

        sensitivity = 0;
      };

      "device:ydotoold-virtual-device" = {
        kb_layout = "us";
        kb_variant = "";
        kb_options = "";
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(88c0d0ff)";
        "col.inactive_border" = "rgba(4c566aff)";

        layout = "dwindle";
      };

      decoration = {
        rounding = 13;

        blur = {
          enabled = true;
          size = 2;
          passes = 5;
          new_optimizations = true;
          ignore_opacity = true;
          popups = true;
          popups_ignorealpha = 0.8;
        };

        drop_shadow = true;
        shadow_range = 20;
        "col.shadow_inactive" = "rgba(00000000)";
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
        no_direct_scanout = true;
        animate_manual_resizes = false;
        animate_mouse_windowdragging = true;
        disable_autoreload = true;
        focus_on_activate = false;
        disable_hyprland_logo = true;
      };

      master = {
        new_is_master = true;
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 4;
        workspace_swipe_distance = 300;
        workspace_swipe_invert = true;
        workspace_swipe_min_speed_to_force = 0;
        workspace_swipe_cancel_ratio = 0.1;
      };

      layerrule = [
        "blur, rofi"
        "ignorezero, rofi"

        "noanim, waybar"
        "ignorezero, waybar"
        "blur, waybar"

        "blur, notifications"
        "ignorezero, notifications"
      ];

      windowrulev2 = [
        # "nomaxsize, class:^(winecfg\\.exe)$"
        # "float, class:^(winecfg\\.exe)$"
        # "size 677 841, class:^(winecfg\\.exe)$"

        "float, class:^(showmethekey-gtk)$, title:^(Floating Window - Show Me The Key)$"
        "opacity 0.5 override 0.5 override, class:^(showmethekey-gtk)$, title:^(Floating Window - Show Me The Key)$"
        "pin, class:^(showmethekey-gtk)$, title:^(Floating Window - Show Me The Key)$"
        "float, class:^(pavucontrol-qt)$"
        "float, class:^(org.kde.polkit-kde-authentication-agent-1)$"
        "tile, class:^(neovide)$"
        "tile, class:^(wpsoffice)$"
        "tile, class:^(Vivaldi-stable)$"
        "tile, title:^(.*Logisim-evolution v3.8.0)$"
        "tile, class:^(DesktopEditors)$"
        "opacity 0.8 override 0.8 override, class:^(obsidian)$"
        "opacity 0.8 override 0.8 override, class:^(discord)$"
        "opacity 0.8 override 0.8 override, class:^(Code)$"
        "opacity 0.8 override 0.8 override, class:^(thunderbird)$"
        "opacity 0.8 override 0.8 override, class:^(org.telegram.desktop)$"
        "opacity 0.8 override 0.8 override, class:^(QQ)$"
        "opacity 0.8 override 0.8 override, class:^(code-url-handler)$"
        "opacity 0.8 override 0.8 override, class:^(kitty)$"
        "opacity 0.8 override 0.8 override, class:^(firefox)$"
        "fullscreen, class:^(mpv)$"
        "float, class:^(SVPManager)$"
        "stayfocused, title:^()$,class:^(steam)$"
        "minsize 1 1, title:^()$,class:^(steam)$"
      ];

      xwayland = {
        use_nearest_neighbor = false;
        force_zero_scaling = true;
      };
    };
  };

  home.packages = with pkgs; [ wl-clipboard ];
}
