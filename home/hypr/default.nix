{ useNvidia, extMonitor }: { pkgs, lib, extraRepos, info, ... }: {
  imports =
    (if useNvidia then [ ./nvidia.nix ] else [ ./intel.nix ]) ++
    (if !extMonitor then [ ./noExtMonitor.nix ] else [ ]) ++ [
      ./keybindings.nix
    ];
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = lib.mkDefault [
        "DP-2,2560x1440@170,0x0,1"
        "eDP-1,2560x1440@240,2560x0,1"
        "monitor=HDMI-A-1,disabled"
      ];

      workspace = lib.mkDefault [
        "1, monitor:eDP-1"
        "2, monitor:eDP-1"
        "3, monitor:eDP-1"
        "4, monitor:eDP-1"
        "5, monitor:eDP-1"
        "6, monitor:eDP-1"
        "7, monitor:eDP-1"
        "8, monitor:eDP-1"
        "9, monitor:DP-2"
        "10, monitor:DP-2, default:true"
      ];

      env = [
        "LANG,zh_CN.UTF-8"

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
        "clash-verge"
        "fcitx5 -d"
        "go env -w GOPROXY=https://goproxy.cn,direct"
        "hyprctl setcursor 'Capitaine Cursors (Nord)' 24"
        "imwheel"
        "killall clash-meta"
        "nm-applet"
        "swww init"
        "waybar"
        "wl-clip-persist --clipboard both"
        "ydotoold"
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

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgb(d8dee9)";
        "col.inactive_border" = "rgba(4c566aff)";

        layout = "dwindle";
      };

      decoration = {
        rounding = 13;

        blur = {
          enabled = true;
          size = 2;
          passes = 1;
          new_optimizations = true;
          ignore_opacity = true;
        };

        drop_shadow = false;
        shadow_range = 5;
        shadow_render_power = 5;
        "col.shadow" = "rgba(000000ff)";
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
        focus_on_activate = false;
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

        "float, class:^(pavucontrol-qt)$"
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
        "opacity 0.8 override 0.8 override, class:^(Code - Insiders)$"
        "opacity 0.8 override 0.8 override, class:^(kitty)$"
        "fullscreen, class:^(mpv)$"
        "float, class:^(SVPManager)$"
        "stayfocused, title:^()$,class:^(steam)$"
        "minsize 1 1, title:^()$,class:^(steam)$"
      ];
    };
  };

  home.packages = with pkgs; with extraRepos; [
    networkmanagerapplet
    swww
    wl-clipboard
    hyprland-contrib.packages.${pkgs.system}.grimblast
    pamixer
  ];
}
