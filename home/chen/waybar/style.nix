{
  programs.waybar.style = ''
    * {
        font-family: 'Symbols Nerd Font', 'Sarasa Mono SC', 'Maple Mono', sans-serif;
        font-size: 16px;
        font-weight: bold;
    }

    window#waybar {
        background-color: transparent;
        color: #d8dee9;
    }

    #workspaces button {
        margin: 5px;
        font-weight: normal;
        padding: 0 3px;
        background-color: #d8dee9;
        border-radius: 8px;
        transition-property: background-color, color;
        transition-duration: .5s;
        color: #2e3440;
    }

    #workspaces label {
        padding-top: 1px;
    }

    #workspaces button:hover {
        color: #d8dee9;
        background: #2e3440;
    }

    #workspaces button.active {
        color: #d8dee9;
        background-color: #5e81ac;
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
    #custom-cava,
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
        padding: 0 12px;
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
        margin-right: 5px;
    }

    #battery {
        background-color: #d8dee9;
        color: #2e3440;
    }

    #battery.charging,
    #battery.plugged {
        color: #3b4252;
        background-color: #a3be8c;
    }

    @keyframes blink {
        to {
            background-color: transparent;
            color: #d8dde9;
        }
    }

    #battery.critical:not(.charging) {
        background-color: #bf616a;
        color: #d8dde9;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
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

    #custom-cava {
        border-radius: 0 0 10px 10px;
        margin-top: 0;
        padding: 0 15px;
        letter-spacing: 2px;
        background-color: rgba(0, 0, 0, 0.2);
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
        border-radius: 10px;
        background-color: rgba(0, 0, 0, 0.2);
    }

    #tray>.passive {
        -gtk-icon-effect: dim;
    }

    #tray>.needs-attention {
        -gtk-icon-effect: highlight;
        background-color: #bf616a;
    }

    #mpris {
        margin-left: 5px;
        font-weight: bold;
    }
  '';
}
