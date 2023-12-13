{
  programs.waybar.style = ''
    * {
        font-family: 'Symbols Nerd Font', 'Maple Mono', 'FiraCode Nerd Font', Helvetica, Arial, sans-serif;
        font-size: 20px;
        font-weight: 500;
    }

    window#waybar {
        background-color: rgba(46, 52, 64, 0.3);
        color: #D8DEE9;
        border-radius: 0 0 10px 10px;
    }

    window#waybar.hidden {
        opacity: 0.2;
    }

    window#waybar.termite {
        background-color: #3B4252;
    }

    window#waybar.chromium {
        background-color: #2E3440;
        border: none;
    }

    button {
        box-shadow: inset 0 -3px transparent;
        border: none;
        border-radius: 0;
    }

    button:hover {
        background: inherit;
    }

    #workspaces button {
        margin: 0 0 5px 5px;
        padding-top: 2px;
        background-color: transparent;
        border-radius: 0 0 8px 8px;
        transition-property: all;
        transition-duration: .5s;
        color: #D8DEE9;
        border-top: 3px solid rgba(0, 0, 0, 0);
    }

    #workspaces button:hover {
        background: #4C566A;
    }

    #workspaces button.active {
        background-color: #4c566a;
        border-color: #a3be8c;
    }

    #workspaces button.urgent {
        border-color: #bf616a;
    }

    #mode {
        background-color: #4C566A;
        border-bottom: 3px solid #ECEFF4;
    }

    #clock,
    #battery,
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
        color: #eceff4;
        border-radius: 10px;
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
        color: #2E3440;
    }

    #battery.charging,
    #battery.plugged {
        color: #3b4252;
        background-color: #a3be8c;
    }

    @keyframes blink {
        to {
            background-color: #d8dde9;
            color: #2E3440;
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
        color: #d8dee9;
        margin-left: 10px;
        letter-spacing: 2px;
    }

    #temperature {
        background-color: #88c0d0;
        color: #434c5e
    }

    #temperature.critical {
        background-color: #bf616a;
    }

    #tray {
        background-color: transparent;
        margin-right: 8px;
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
