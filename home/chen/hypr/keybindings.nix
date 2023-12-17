{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
    bind = [
      "$mainMod, Return, exec, kitty"
      "$mainMod, Y, exec, obsidian"
      # "$mainMod, U, exec, vivaldi --force-dark-mode"
      "$mainMod, U, exec, firefox"
      "$mainMod, Q, exec, rofi -kb-row-up Alt+e -kb-row-down Alt+n -show drun"
      "$mainMod, O, exec, rofi -kb-row-up Alt+e -kb-row-down Alt+n -show run"
      "$mainMod, Backslash, exec, rofi -kb-row-up Alt+e -kb-row-down Alt+n -show ssh"
      "$mainMod, Semicolon, exec, rofi-rbw --target password --selector-args '-kb-row-up Alt+e -kb-row-down Alt+n'"
      "$mainMod, K, exec, rofi -show calc -modi calc -no-show-match -no-sort -calc-command \"echo -n '{result}' | wl-copy\" -kb-row-up Alt+e -kb-row-down Alt+n"
      "$mainMod, Space, exec, rofi -show ts -modi ts -no-sort -ts-command \"echo -n '{data}' | wl-copy\" -kb-row-up Alt+e -kb-row-down Alt+n"
      "$mainMod SHIFT, R, exec, grimblast copy area"

      "$mainMod SHIFT, Q, killactive, "
      "$mainMod SHIFT, Space, togglefloating, "
      "$mainMod, T, fullscreen, 0"

      "$mainMod, H, movefocus, l"
      "$mainMod, I, movefocus, r"
      "$mainMod, N, movefocus, d"
      "$mainMod, E, movefocus, u"

      "$mainMod SHIFT, H, swapwindow, l"
      "$mainMod SHIFT, I, swapwindow, r"
      "$mainMod SHIFT, N, swapwindow, d"
      "$mainMod SHIFT, E, swapwindow, u"

      "$mainMod, V, togglesplit, "

      "$mainMod, Escape, workspace, 1"
      "$mainMod, A, workspace, 2"
      "$mainMod, Z, workspace, 3"
      "$mainMod, B, workspace, 4"
      "$mainMod, M, workspace, 5"
      "$mainMod, S, workspace, 6"
      "$mainMod, L, workspace, 7"
      "$mainMod, W, workspace, 8"
      "$mainMod, F, workspace, 9"
      "$mainMod, Comma, workspace, 10"

      "$mainMod SHIFT, Escape, movetoworkspace, 1"
      "$mainMod SHIFT, A, movetoworkspace, 2"
      "$mainMod SHIFT, Z, movetoworkspace, 3"
      "$mainMod SHIFT, B, movetoworkspace, 4"
      "$mainMod SHIFT, M, movetoworkspace, 5"
      "$mainMod SHIFT, S, movetoworkspace, 6"
      "$mainMod SHIFT, L, movetoworkspace, 7"
      "$mainMod SHIFT, W, movetoworkspace, 8"
      "$mainMod SHIFT, F, movetoworkspace, 9"
      "$mainMod SHIFT, Comma, movetoworkspace, 10"
      "$mainMod, mouse_down, workspace, e+1"
      "$mainMod, mouse_up, workspace, e-1"
    ];

    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    binde = [
      ", XF86AudioRaiseVolume, exec, pamixer -i 5"
      ", XF86AudioLowerVolume, exec, pamixer -d 5"
      ", XF86AudioMute, exec, pamixer -t"
      ", XF86MonBrightnessUp, exec, backlight_control +5"
      ", XF86MonBrightnessDown, exec, backlight_control -5"
    ];
  };
}
