{ config, pkgs, lib, extraRepos, ... }:
let
  cfg = config.hypr;

  hyprctl = extraRepos.hyprland.hyprland + "/bin/hyprctl";
  jq = lib.getExe pkgs.jq;
  grep = lib.getExe pkgs.gnugrep;

  fake-fullscreen-qq = pkgs.writeShellScript "fake-fullscreen-qq" ''
    ${hyprctl} -j activewindow | ${jq} -r .initialClass | ${grep} -q '^QQ$' &&
        ${hyprctl} dispatch -- fullscreenstate 2 1 ||
        ${hyprctl} dispatch fullscreen
  '';
in
{
  config.hmConfig.wayland.windowManager.hyprland.settings = lib.mkIf cfg.enable {
    "$mainMod" = "SUPER";
    bind =
      let
        colemak = config.colemak.enable;
        rofi-kb = "-kb-row-up Alt+${if colemak then "e" else "k"} -kb-row-down Alt+${if colemak then "n" else "j"}";
      in
      lib.mkMerge [
        (lib.mkIf config.terminal.enable [ "$mainMod, Return, exec, ${config.terminal.preferred}" ])
        (lib.mkIf config.obsidian.enable [ "$mainMod, ${if colemak then "Y" else "O"}, exec, obsidian" ])
        (lib.mkIf (config.vivaldi.enable || config.firefox.enable) [
          "$mainMod, ${if colemak then "U" else "I"}, exec, ${if config.firefox.enable then "firefox" else "vivaldi"}"
        ])
        (lib.mkIf config.programs.utility.rofi.enable [
          "$mainMod, Q, exec, rofi ${rofi-kb} -show drun"
          "$mainMod, ${if colemak then "O" else "Semicolon"}, exec, rofi ${rofi-kb} -show run"
          "$mainMod, Backslash, exec, rofi ${rofi-kb} -show ssh"
          "$mainMod, ${if colemak then "K" else "N"}, exec, rofi -show calc -modi calc -no-show-match -no-sort -calc-command \"echo -n '{result}' | wl-copy\" ${rofi-kb}"
          "$mainMod, Space, exec, rofi -show ts -modi ts -no-sort -ts-command \"echo -n '{result}' | wl-copy\" ${rofi-kb}"
        ])
        (lib.mkIf config.programs.utility.rbw.enable [
          "$mainMod, ${if colemak then "Semicolon" else "P"}, exec, ${lib.getExe pkgs.rofi-rbw-wayland} --target password --selector-args '${rofi-kb}'"
        ])
        [
          "$mainMod SHIFT, ${if colemak then "R" else "S"}, exec, ${lib.getExe pkgs.grimblast} --notify --freeze copy area"
          "$mainMod SHIFT, Q, killactive, "
          "$mainMod SHIFT, Space, togglefloating, "
          "$mainMod, ${if colemak then "T" else "F"}, exec, ${fake-fullscreen-qq}"
          "$mainMod, Up, fullscreen, 1"

          "$mainMod, H, movefocus, l"
          "$mainMod, ${if colemak then "I" else "L"}, movefocus, r"
          "$mainMod, ${if colemak then "N" else "J"}, movefocus, d"
          "$mainMod, ${if colemak then "E" else "K"}, movefocus, u"

          "$mainMod SHIFT, H, swapwindow, l"
          "$mainMod SHIFT, ${if colemak then "I" else "L"}, swapwindow, r"
          "$mainMod SHIFT, ${if colemak then "N" else "J"}, swapwindow, d"
          "$mainMod SHIFT, ${if colemak then "E" else "K"}, swapwindow, u"

          "$mainMod, V, togglesplit, "

          "$mainMod, Escape, workspace, 1"
          "$mainMod, A, workspace, 2"
          "$mainMod, Z, workspace, 3"
          "$mainMod, B, workspace, 4"
          "$mainMod, M, workspace, 5"
          "$mainMod, ${if colemak then "S" else "D"}, workspace, 6"
          "$mainMod, ${if colemak then "L" else "U"}, workspace, 7"
          "$mainMod, W, workspace, 8"
          "$mainMod, ${if colemak then "F" else "E"}, workspace, 9"
          "$mainMod, Comma, workspace, 10"

          "$mainMod SHIFT, Escape, movetoworkspace, 1"
          "$mainMod SHIFT, A, movetoworkspace, 2"
          "$mainMod SHIFT, Z, movetoworkspace, 3"
          "$mainMod SHIFT, B, movetoworkspace, 4"
          "$mainMod SHIFT, M, movetoworkspace, 5"
          "$mainMod SHIFT, ${if colemak then "S" else "D"}, movetoworkspace, 6"
          "$mainMod SHIFT, ${if colemak then "L" else "U"}, movetoworkspace, 7"
          "$mainMod SHIFT, W, movetoworkspace, 8"
          "$mainMod SHIFT, ${if colemak then "F" else "E"}, movetoworkspace, 9"
          "$mainMod SHIFT, Comma, movetoworkspace, 10"
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
        ]
      ];

    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    binde = [
      ", XF86AudioRaiseVolume, exec, ${lib.getExe pkgs.pamixer} -i 5"
      ", XF86AudioLowerVolume, exec, ${lib.getExe pkgs.pamixer} -d 5"
      ", XF86AudioMute, exec, ${lib.getExe pkgs.pamixer} -t"
      ", XF86MonBrightnessUp, exec, ${lib.getExe pkgs.brightnessctl} set 5%+"
      ", XF86MonBrightnessDown, exec, ${lib.getExe pkgs.brightnessctl} set 5%-"
    ];
  };
}

