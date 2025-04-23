{ config, lib, ... }:
let
  cfg = config.waybar;
in
{
  config.hmConfig = lib.mkIf cfg.enable {
    programs.waybar.style = ''
      * {
          font-family: 'Noto Sans Mono CJK SC', 'Symbols Nerd Font';
          font-size: 16px;
          font-weight: bold;
      }

      window#waybar {
          background-color: transparent;
          color: #d8dee9;
      }

      #workspaces button {
          margin: 5px;
          padding: 0 5px;
          background-color: #2e3440;
          border-radius: 8px;
          border-width: 2px;
          transition-property: background-color, color, border-color;
          transition-duration: .5s;
          color: #88c0d0;
      }

      #workspaces label {
          font-weight: normal;
          margin-top: 2px;
      }

      #workspaces button:hover {
          color: #d8dee9;
          background: #2e3440;
      }

      #workspaces button.active {
          color: #2e3440;
          background-color: #88c0d0;
          border-color: #4c566a;
      }

      #workspaces button.urgent {
          color: #d8dee9;
          background-color: #bf616a;
      }

      #mode {
          background-color: #4c566a;
          border-bottom: 3px solid #eceff4;
      }

      #clock,
      #battery,
      #mpris,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #wireplumber,
      #tray,
      #mode,
      #idle_inhibitor,
      #scratchpad,
      #keyboard-state,
      #mpd {
          margin: 5px 2px;
          padding-left: 12px;
          padding-right: 12px;
          padding-bottom: 2px;
          color: #d8dee9;
          border-radius: 10px;
      }

      #network {
          font-size: 10px;
      }

      #window,
      #workspaces {
          margin: 0 4px;
      }

      #window {
          font-weight: bold;
          font-size: small;
      }

      .modules-left>widget:first-child>#workspaces {
          margin-left: 5px;
      }

      .modules-right>widget:last-child>#workspaces {
          margin-right: 0;
      }

      #clock {
          color: #434c5e;
          background-color: #81a1c1;
      }

      #battery {
          margin: 5px 2px;
          padding-left: 12px;
          padding-right: 12px;
          color: #d8dee9;
          border-radius: 10px;
          background-color: #2e3440;
          color: #88c0d0;
      }

      #battery.full {
          padding-top: 2px;
          padding-bottom: 0;
      }

      #battery.charging,
      #battery.plugged {
          color: #3b4252;
          background-color: #a3be8c;
      }

      @keyframes blink {
          to {
              background-color: black;
              color: #d8dde9;
          }
      }

      #battery.critical:not(.charging) {
          background-color: #bf616a;
          color: #d8dde9;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: ease;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      label:focus {
          background-color: #2E3440;
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
          background-color: #4c566a;
          color: #d8dee9;
      }

      #network.disconnected {
          background-color: #bf616a;
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
          font-family: 'Symbols Nerd Font', 'Noto Sans CJK SC';
          border-radius: 0 0 10px 10px;
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
          margin-right: 8px;
          background-color: transparent;
      }

      #tray menu * {
          font-family: 'Noto Sans CJK SC';
      }

      #tray>widget {
          border-radius: 10px;
          border: 2px solid #88c0d0;
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
