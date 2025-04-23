{ config, lib, ... }:
let
  cfg = config.waybar;
in
{
  config.hmConfig = lib.mkIf cfg.enable {
    programs.waybar.style = ''
      window#waybar {
          background-color: transparent;
      }

      #workspaces,
      #tray {
          margin-top: 5px;
      }

      #workspaces label {
          font-family: 'Symbols Nerd Font';
          font-weight: normal;
          font-size: 16px;
          padding-top: 2px;
      }

      #workspaces button {
          margin-right: 5px;
          padding: 0 5px;
          color: #88c0d0;
          background-color: #2e3440;
          border-radius: 8px;
          transition-property: background-color, color;
          transition-duration: .5s;
      }

      #workspaces button:hover {
          background-color: #3b4252;
      }

      #workspaces button.active {
          color: #2e3440;
          background-color: #88c0d0;
      }

      #workspaces button.urgent {
          color: #bf616a;
          background-color: #2e3440;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #temperature,
      #backlight,
      #network,
      #pulseaudio {
          margin-right: 5px;
          margin-top: 5px;

          padding: 0 12px;
          color: #d8dee9;
          border-radius: 8px;
          font-family: 'Symbols Nerd Font', 'Maple Mono';
          font-size: 16px;
          font-weight: 600;
          min-height: 28px;
      }

      #network {
          font-size: 10px;
      }

      #workspaces {
          margin-left: 10px;
      }

      #clock {
          color: #434c5e;
          background-color: #81a1c1;
      }

      #battery {
          background-color: #2e3440;
          color: #88c0d0;
      }

      #battery.charging,
      #battery.plugged {
          color: #a3be8c;
      }

      @keyframes blink {
          to {
              color: #bf616a
          }
      }

      #battery.critical:not(.charging) {
          color: #88c0d0;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: ease;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      #cpu {
          background-color: #81a1c1;
          color: #434c5e
      }

      #memory {
          background-color: #8fbcbb;
          color: #434c5e;
      }

      #disk {
          background-color: #3b4252;
      }

      #backlight {
          background-color: #8fbcbb;
          color: #434c5e;
      }

      #network {
          background-color: #2e3440;
          color: #88c0d0;
      }

      #network.disconnected {
          color: #bf616a;
      }

      #pulseaudio {
          background-color: #88c0d0;
          color: #434c5e;
      }

      #pulseaudio.muted {
          background-color: #90b1b1;
          color: #2a5c45;
      }

      #mpris {
          font-family: 'Symbols Nerd Font', 'MiSans';
          font-size: 16px;
          font-weight: normal;
          border-radius: 0 0 8px 8px;
          margin-top: 0;
          padding: 0 15px;
          min-width: 200px;
          color: #88c0d0;
          background-color: #2e3440;
      }

      #temperature {
          background-color: #88c0d0;
          color: #434c5e
      }

      #temperature.critical {
          background-color: #bf616a;
      }

      #tray {
          margin-right: 10px;
          background-color: transparent;
      }

      #tray menu * {
          font-family: 'Noto Sans CJK SC';
      }

      #tray>widget {
          border-radius: 8px;
          background-color: #2e3440;
      }

      #tray>widget>image {
          padding: 0 7px;
      }

      #tray>.passive {
          -gtk-icon-effect: dim;
      }

      #tray>.needs-attention {
          -gtk-icon-effect: highlight;
          background-color: #bf616a;
      }
    '';
  };
}
