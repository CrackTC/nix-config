{ config, lib, ... }:
let cfg = config.waybar; in {
  config.hmConfig = lib.mkIf cfg.enable {
    programs.waybar.settings.mainBar."network" = {
      interval = 1;
      format-wifi = "↑{bandwidthUpBytes:>5}\r↓{bandwidthDownBytes:>5}";
      format-linked = " {ifname} (No IP)";
      format-ethernet = "↑{bandwidthUpBytes:>5}\r↓{bandwidthDownBytes:>5}";
      format-disconnected = "󰌸 DOWN";
      format-alt = " {ifname}\r {ipaddr}/{cidr}";
      tooltip-format = "{ifname} via  {gwaddr}";
    };
  };
}
