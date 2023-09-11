{
  programs.waybar.settings.mainBar."network" = {
    interval = 1;
    format-wifi = "󰖩  ↑ {bandwidthUpBytes} ↓ {bandwidthDownBytes}";
    format-linked = " {ifname} (No IP)";
    format-ethernet = "<span rise='1500'></span> ↑ {bandwidthUpBytes} ↓ {bandwidthDownBytes}";
    format-disconnected = "";
    format-alt = "{ifname}= {ipaddr}/{cidr}";
    tooltip-format = "{ifname} via  {gwaddr}";
  };
}
