{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.hypr;

  mkBind =
    keys: dispatcher:
    # lua
    ''
      hl.bind("${keys}", ${dispatcher})
    '';

  mkBindExec =
    keys: command:
    mkBind keys
      # lua
      ''hl.dsp.exec_cmd("${lib.replaceStrings [ ''"'' ] [ ''\"'' ] command}")'';

  mkBindExecRepeating =
    keys: command:
    mkBind keys
      # lua
      ''hl.dsp.exec_cmd("${lib.replaceStrings [ ''"'' ] [ ''\"'' ] command}"), { repeating = true }'';
in
{
  config.hmConfig.wayland.windowManager.hyprland = {
    extraConfig = lib.mkIf cfg.enable (
      let
        colemak = config.colemak.enable;
        rofi-kb = "-kb-row-up Alt+${if colemak then "e" else "k"} -kb-row-down Alt+${if colemak then "n" else "j"}";
      in
      lib.mkMerge [
        (lib.mkIf config.terminal.enable (
          mkBindExec "SUPER + Return" "${config.terminal.preferred}${
            if config.terminal.preferred == "ghostty" then " --gtk-single-instance=true" else ""
          }"
        ))
        (lib.mkIf config.obsidian.enable (mkBindExec "SUPER + ${if colemak then "Y" else "O"}" "obsidian"))
        (lib.mkIf (config.chrome.enable || config.firefox.enable) (
          mkBindExec "SUPER + ${if colemak then "U" else "I"}" (
            if config.firefox.enable then "firefox" else "google-chrome-stable"
          )
        ))
        (lib.mkIf config.programs.utility.rofi.enable (
          lib.mkMerge [
            (mkBindExec "SUPER + Q" "rofi ${rofi-kb} -show drun")
            (mkBindExec "SUPER + ${if colemak then "O" else "Semicolon"}" "rofi ${rofi-kb} -show run")
            (mkBindExec "SUPER + Backslash" "rofi ${rofi-kb} -show ssh")
            (mkBindExec "SUPER + ${if colemak then "K" else "N"}" "rofi -show calc -modi calc -no-show-match -no-sort -calc-command \"echo -n '{result}' | wl-copy\" ${rofi-kb}")
            (mkBindExec "SUPER + Space" "rofi -show ts -modi ts -no-sort -ts-command \"echo -n '{result}' | wl-copy\" ${rofi-kb}")
          ]
        ))
        (lib.mkIf config.programs.utility.rbw.enable (
          mkBindExec "SUPER + ${if colemak then "Semicolon" else "P"}" "${lib.getExe pkgs.rofi-rbw-wayland} --target password --selector-args '${rofi-kb}'"
        ))

        # lua
        ''
          ${lib.concatStringsSep "\n" [
            (mkBindExec "SUPER + SHIFT + ${if colemak then "R" else "S"}" "${lib.getExe pkgs.grimblast} --notify --freeze copy area")
            (mkBind "SUPER + SHIFT + Q" "hl.dsp.window.close()")
            (mkBind "SUPER + SHIFT + Space" "hl.dsp.window.float()")
            (mkBind "SUPER + ${if colemak then "T" else "F"}"
              # lua
              ''
                function ()
                  local active_window = hl.get_active_window()
                  if not active_window then return end
                  if active_window.initial_class == "QQ" then
                    hl.dispatch(hl.dsp.window.fullscreen_state({
                      internal = 2,
                      client = 1,
                      action = "toggle",
                    }))
                  else
                    hl.dispatch(hl.dsp.window.fullscreen())
                  end
                end
              ''
            )
            (mkBind "SUPER + Up" "hl.dsp.window.fullscreen({ mode = 'maximized' })")
            (mkBind "SUPER + H" "hl.dsp.focus({ direction = 'l' })")
            (mkBind "SUPER + ${if colemak then "I" else "L"}" "hl.dsp.focus({ direction = 'r' })")
            (mkBind "SUPER + ${if colemak then "N" else "J"}" "hl.dsp.focus({ direction = 'd' })")
            (mkBind "SUPER + ${if colemak then "E" else "K"}" "hl.dsp.focus({ direction = 'u' })")
            (mkBind "SUPER + SHIFT + H" "hl.dsp.window.swap({ direction = 'l' })")
            (mkBind "SUPER + SHIFT + ${if colemak then "I" else "L"}" "hl.dsp.window.swap({ direction = 'r' })")
            (mkBind "SUPER + SHIFT + ${if colemak then "N" else "J"}" "hl.dsp.window.swap({ direction = 'd' })")
            (mkBind "SUPER + SHIFT + ${if colemak then "E" else "K"}" "hl.dsp.window.swap({ direction = 'u' })")
            (mkBind "SUPER + V" "hl.dsp.layout('togglesplit')")
            (mkBind "SUPER + Comma" "hl.dsp.focus({ workspace = '1' })")
            (mkBind "SUPER + Escape" "hl.dsp.focus({ workspace = '2' })")
            (mkBind "SUPER + A" "hl.dsp.focus({ workspace = '3' })")
            (mkBind "SUPER + Z" "hl.dsp.focus({ workspace = '4' })")
            (mkBind "SUPER + B" "hl.dsp.focus({ workspace = '5' })")
            (mkBind "SUPER + M" "hl.dsp.focus({ workspace = '6' })")
            (mkBind "SUPER + ${if colemak then "S" else "D"}" "hl.dsp.focus({ workspace = '7' })")
            (mkBind "SUPER + ${if colemak then "L" else "U"}" "hl.dsp.focus({ workspace = '8' })")
            (mkBind "SUPER + W" "hl.dsp.focus({ workspace = '9' })")
            (mkBind "SUPER + ${if colemak then "F" else "E"}" "hl.dsp.focus({ workspace = '10' })")
            (mkBind "SUPER + SHIFT + Comma" "hl.dsp.window.move({ workspace = '1' })")
            (mkBind "SUPER + SHIFT + Escape" "hl.dsp.window.move({ workspace = '2' })")
            (mkBind "SUPER + SHIFT + A" "hl.dsp.window.move({ workspace = '3' })")
            (mkBind "SUPER + SHIFT + Z" "hl.dsp.window.move({ workspace = '4' })")
            (mkBind "SUPER + SHIFT + B" "hl.dsp.window.move({ workspace = '5' })")
            (mkBind "SUPER + SHIFT + M" "hl.dsp.window.move({ workspace = '6' })")
            (mkBind "SUPER + SHIFT + ${if colemak then "S" else "D"}" "hl.dsp.window.move({ workspace = '7' })")
            (mkBind "SUPER + SHIFT + ${if colemak then "L" else "U"}" "hl.dsp.window.move({ workspace = '8' })")
            (mkBind "SUPER + SHIFT + W" "hl.dsp.window.move({ workspace = '9' })")
            (mkBind "SUPER + SHIFT + ${if colemak then "F" else "E"}" "hl.dsp.window.move({ workspace = '10' })")
            (mkBind "SUPER + mouse_down" "hl.dsp.focus({ workspace = 'e-1' })")
            (mkBind "SUPER + mouse_up" "hl.dsp.focus({ workspace = 'e+1' })")
            (mkBind "SUPER + mouse:272" "hl.dsp.window.drag(), { mouse = true }")
            (mkBind "SUPER + mouse:273" "hl.dsp.window.resize(), { mouse = true }")
            (mkBindExecRepeating "XF86AudioRaiseVolume" "${lib.getExe pkgs.pamixer} -i 5")
            (mkBindExecRepeating "XF86AudioLowerVolume" "${lib.getExe pkgs.pamixer} -d 5")
            (mkBindExecRepeating "XF86AudioMute" "${lib.getExe pkgs.pamixer} -t")
            (mkBindExecRepeating "XF86MonBrightnessUp" "${lib.getExe pkgs.brightnessctl} set 5%+")
            (mkBindExecRepeating "XF86MonBrightnessDown" "${lib.getExe pkgs.brightnessctl} set 5%-")
          ]}
        ''
      ]
    );
  };
}
