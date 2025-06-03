{ config, lib, ... }:
let
  cfg = config.programs.utility.yazi;
in
{
  options.programs.utility.yazi = {
    enable = lib.mkEnableOption "yazi";
  };

  config = lib.mkIf cfg.enable {
    programs.utility.ripdrag.enable = true;
    hmConfig = {
      programs.yazi = {
        enable = true;
        enableBashIntegration = config.programs.shells.bash.enable;
        enableZshIntegration = config.programs.shells.zsh.enable;
        enableFishIntegration = config.programs.shells.fish.enable;
        keymap = {
          mgr.keymap = [
            {
              on = [ "w" ];
              run = ''shell "$SHELL" --block --confirm'';
              desc = "Open shell here";
            }
            {
              on = [ "W" ];
              run = "tasks_show";
            }

            {
              on = [ "q" ];
              run = "quit";
            }

            # navigation
            {
              on = [ "n" ];
              run = "arrow 1";
            }
            {
              on = [ "e" ];
              run = "arrow -1";
            }
            {
              on = [
                "d"
                "d"
              ];
              run = "arrow top";
            }
            {
              on = [ "D" ];
              run = "arrow bot";
            }
            {
              on = [ "<A-k>" ];
              run = "seek 5";
            }
            {
              on = [ "<A-;>" ];
              run = "seek -5";
            }
            {
              on = [ "h" ];
              run = "leave";
            }
            {
              on = [ "i" ];
              run = "plugin smart-enter";
            }
            {
              on = [ "H" ];
              run = "back";
            }
            {
              on = [ "I" ];
              run = "forward";
            }

            # operation
            {
              on = [ "l" ];
              run = "link";
            }
            {
              on = [ "L" ];
              run = "link --relative";
            }
            {
              on = [
                "s"
                "S"
              ];
              run = "remove";
            }
            {
              on = [
                "j"
                "j"
              ];
              run = "yank";
            }
            {
              on = [
                "s"
                "s"
              ];
              run = "yank --cut";
            }
            {
              on = [ ";" ];
              run = "paste";
            }
            {
              on = [ "p" ];
              run = "open --interactive";
            }
            {
              on = [
                "z"
                "h"
              ];
              run = "hidden toggle";
            }
            {
              on = [ "A" ];
              run = "rename --cursor=end";
            }
            {
              on = [
                "m"
                "e"
              ];
              run = "create";
            }
            {
              on = [ "<C-i>" ];
              run = ''
                shell 'ripdrag "$@" -x 2>/dev/null &' --confirm
              '';
            }

            # find
            {
              on = [ "k" ];
              run = "find_arrow";
            }
            {
              on = [ "K" ];
              run = "find_arrow --previous";
            }
            {
              on = [ "/" ];
              run = "find --smart";
            }
            {
              on = [ "?" ];
              run = "find --previous --smart";
            }

            # selection
            {
              on = "<Space>";
              run = [
                "toggle --state=none"
                "arrow 1"
              ];
            }
            {
              on = "v";
              run = "visual_mode";
            }
            {
              on = "V";
              run = "visual_mode --unset";
            }
            {
              on = "<C-a>";
              run = "toggle_all --state=none";
            }
          ];

          tasks.keymap = [
            {
              on = [ "w" ];
              run = "close";
            }
            {
              on = [ "n" ];
              run = "arrow 1";
            }
            {
              on = [ "e" ];
              run = "arrow -1";
            }
            {
              on = [ "<Enter>" ];
              run = "inspect";
            }
            {
              on = [ "x" ];
              run = "cancel";
            }

            {
              on = [ "?" ];
              run = "help";
            }
          ];

          select.keymap = [
            {
              on = [ "n" ];
              run = "arrow 1";
            }
            {
              on = [ "e" ];
              run = "arrow -1";
            }
            {
              on = [ "<A-k>" ];
              run = "seek 5";
            }
            {
              on = [ "<A-;>" ];
              run = "seek -5";
            }

            {
              on = [ "<Esc>" ];
              run = "close";
            }
            {
              on = [ "q" ];
              run = "close";
            }
            {
              on = [ "<Enter>" ];
              run = "close --submit";
            }

            {
              on = [ "?" ];
              run = "help";
            }
          ];

          input.keymap = [
            {
              on = [ "u" ];
              run = "insert";
            }
            {
              on = [ "U" ];
              run = [
                "move -999"
                "insert"
              ];
            }
            {
              on = [ "A" ];
              run = [
                "move 999"
                "insert --append"
              ];
            }

            {
              on = [ "0" ];
              run = "move -999";
            }
            {
              on = [ "$" ];
              run = "move 999";
            }

            {
              on = [ "h" ];
              run = "move -1";
            }
            {
              on = [ "i" ];
              run = "move 1";
            }

            {
              on = [ "f" ];
              run = "forward --end-of-word";
            }

            {
              on = [ "l" ];
              run = "undo";
            }
            {
              on = [ "<C-r>" ];
              run = "redo";
            }

            {
              on = [ "<C-c>" ];
              run = "close";
            }
            {
              on = [ "<Enter>" ];
              run = "close --submit";
            }
            {
              on = [ "<Esc>" ];
              run = "escape";
            }

            {
              on = [ "<Backspace>" ];
              run = "backspace";
            }
            {
              on = [ "<Delete>" ];
              run = "backspace --under";
            }
            {
              on = [ "<C-w>" ];
              run = "kill backward";
            }

            {
              on = [ "?" ];
              run = "help";
            }
          ];

          completion.keymap = [
            {
              on = [ "<C-c>" ];
              run = "close";
            }
            {
              on = [ "<Tab>" ];
              run = "close --submit";
            }
            {
              on = [ "<Enter>" ];
              run = [
                "close --submit"
                "close_input --submit"
              ];
            }

            {
              on = [ "<C-;>" ];
              run = "arrow -1";
            }
            {
              on = [ "<C-k>" ];
              run = "arrow 1";
            }

            {
              on = [ "?" ];
              run = "help";
            }
          ];

          help.keymap = [
            {
              on = [ "q" ];
              run = "close";
            }
            {
              on = [ "n" ];
              run = "arrow 1";
            }
            {
              on = [ "e" ];
              run = "arrow -1";
            }
          ];
        };
        plugins = {
          smart-enter = ./plugins/smart-enter;
        };
      };
    };
  };
}
