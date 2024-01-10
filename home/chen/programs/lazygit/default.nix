{ info, ... }: {
  programs.lazygit.enable = true;
  programs.lazygit.settings = {
    gui = {
      theme = {
        activeBorderColor = [ "blue" "bold" ];
        inactiveBorderColor = [ "#4c566a" ];
        selectedLineBgColor = [ "black" ];
        selectedRangeBgColor = [ "black" ];
      };

      authorColors = {
        "${info.nickname}" = "#8fbcbb";
        "*" = "blue";
      };

      nerdFontsVersion = "3";
      showBottomLine = false;
    };

    git.parseEmoji = true;

    os = {
      edit = "kitty -- nvim -- {{filename}}";
      editAtLine = "kitty -- nvim +{{line}} -- {{filename}}";
      editAtLineAndWait = "kitty -- nvim +{{line}} -- {{filename}}";
      openDirInEditor = "kitty -- nvim -- {{dir}}";
    };

    update.method = "never";

    notARepository = "quit";

    promptToReturnFromSubprocess = false;

    keybinding = {
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
        jumpToBlock = "[1,2,3,4,5]";
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
        executeCustomCommand = "<c-p>";
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
    };
  };
}
