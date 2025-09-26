{ config, lib, ... }:
let
  cfg = config.programs.utility.lazygit;
  terminal = config.terminal.preferred;
in
{
  options.programs.utility.lazygit = {
    enable = lib.mkEnableOption "lazygit";
  };

  config.hmConfig = lib.mkIf cfg.enable {
    programs.lazygit.enable = true;
    programs.lazygit.settings = {
      gui = {
        theme = {
          activeBorderColor = [
            "blue"
            "bold"
          ];
          inactiveBorderColor = [ "#4c566a" ];
          selectedLineBgColor = [ "black" ];
          selectedRangeBgColor = [ "black" ];
        };

        authorColors = {
          "${config.nickname}" = "#8fbcbb";
          "*" = "blue";
        };

        nerdFontsVersion = "3";
        showBottomLine = false;
      };

      git.parseEmoji = true;

      os = lib.mkIf (config.terminal.enable && config.editors.nvim.enable) {
        edit = "${terminal} -- nvim -- {{filename}}";
        editAtLine = "${terminal} -- nvim +{{line}} -- {{filename}}";
        editAtLineAndWait = "${terminal} -- nvim +{{line}} -- {{filename}}";
        openDirInEditor = "${terminal} -- nvim -- {{dir}}";
      };

      update.method = "never";

      notARepository = "quit";

      promptToReturnFromSubprocess = false;

      keybinding = lib.mkIf config.colemak.enable {
        universal = {
          quit = "q";
          quit-alt1 = "<c-c>";
          return = "<esc>";
          quitWithoutChangingDirectory = "Q";
          togglePanel = "<tab>";
          prevItem = "<up>";
          nextItem = "<down>";
          prevItem-alt = "e";
          nextItem-alt = "n";
          prevPage = ",";
          nextPage = ".";
          gotoTop = "d";
          gotoBottom = "D";
          scrollLeft = "h";
          scrollRight = "i";
          prevBlock = "<left>";
          nextBlock = "<right>";
          prevBlock-alt = "E";
          nextBlock-alt = "N";
          jumpToBlock = [
            1
            2
            3
            4
            5
          ];
          nextMatch = "k";
          prevMatch = "K";
          optionMenu-alt1 = "?";
          select = "<space>";
          goInto = "<enter>";
          openRecentRepos = "<c-r>";
          confirm = "<enter>";
          remove = "s";
          new = "k";
          edit = "f";
          openFile = "y";
          scrollUpMain = "<pgup>";
          scrollDownMain = "<pgdown>";
          scrollUpMain-alt1 = "<c-e>";
          scrollDownMain-alt1 = "<c-n>";
          executeShellCommand = "<c-p>";
          pushFiles = ":";
          pullFiles = ";";
          refresh = "P";
          createPatchOptionsMenu = "o";
          nextTab = "I";
          prevTab = "H";
          nextScreenMode = "<c-y>";
          undo = "l";
          redo = "<c-r>";
        };

        branches = {
          moveCommitsToNewBranch = "K";
        };

        files = {
          stashAllChanges = "r";
          viewStashOptions = "R";
        };
      };
    };
  };
}
