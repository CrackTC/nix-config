{
  programs.waybar.settings.mainBar."network" = {
    interval = 1;
    format-wifi = "↑{bandwidthUpBytes:>5}\r↓{bandwidthDownBytes:>5}";
    format-linked = " {ifname} (No IP)";
    format-ethernet = "↑{bandwidthUpBytes:>5}\r↓{bandwidthDownBytes:>5}";
    format-disconnected = "";
    format-alt = "{ifname} = {ipaddr}/{cidr}";
    tooltip-format = "{ifname} via  {gwaddr}";
  };
}
