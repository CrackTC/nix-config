{ config, lib, ... }:
let
  cfg = config.waybar;
in
{
  config.hmConfig = lib.mkIf cfg.enable {
    programs.waybar.settings.mainBar."network" = {
      interval = 1;
      format-wifi = "<span line_height='12288'>↑{bandwidthUpBytes:>5}\r↓{bandwidthDownBytes:>5}</span>";
      format-linked = " {ifname} (No IP)";
      format-ethernet = "<span line_height='12288'>↑{bandwidthUpBytes:>5}\r↓{bandwidthDownBytes:>5}</span>";
      format-disconnected = "<span size='150%'>󰌸 DOWN</span>";
      format-alt = "<span line_height='12288'> {ifname}\r {ipaddr}/{cidr}</span>";
      tooltip-format = "{ifname} via  {gwaddr}";
    };
  };
}
