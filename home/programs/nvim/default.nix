{ config, info, ... }: {
  xdg.configFile = {
    "nvim/init.lua".source = ./config/init.lua;
    "nvim/lua" = {
      source = ./config/lua;
      recursive = true;
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    coc = {
      enable = true;
      settings = {
        "coc.preferences.extensionUpdateCheck" = "daily";
        "coc.preferences.enableMessageDialog" = false;
        "coc.preferences.messageLevel" = "error";
        "coc.source.around.enable" = false;
        "coc.source.buffer.enable" = false;
        "codeLens.enable" = true;
        "inlayHint.display" = true;
        "inlayHint.enableParameter" = true;
        "inlayHint.parameterSeparator" = "󰶻 ";
        "inlayHint.refreshOnInsertMode" = true;
        "suggest.autoTrigger" = "always";
        "suggest.detailField" = "preview";
        "floatFactory.floatConfig" = {
          "rounded" = true;
          "border" = true;
        };
        "suggest.floatConfig" = {
          "rounded" = true;
          "border" = true;
        };
        "hover.floatConfig" = {
          "rounded" = true;
          "border" = true;
        };
        "signature.floatConfig" = {
          "rounded" = true;
          "border" = true;
        };
        "diagnostic.floatConfig" = {
          "rounded" = true;
          "border" = true;
        };
        "suggest.pumFloatConfig" = {
          "rounded" = true;
          "border" = true;
        };
        "suggest.labelMaxLength" = 40;
        "suggest.noselect" = false;
        "suggest.snippetIndicator" = " ";
        "suggest.timeout" = 5000;
        "suggest.triggerAfterInsertEnter" = true;
        "suggest.completionItemKindLabels" = {
          "class" = " ";
          "color" = " ";
          "constant" = " ";
          "default" = " ";
          "enum" = " ";
          "enumMember" = " ";
          "event" = " ";
          "field" = " ";
          "file" = " ";
          "folder" = " ";
          "function" = "󰊕";
          "interface" = " ";
          "keyword" = " ";
          "method" = " ";
          "module" = " ";
          "operator" = " ";
          "property" = " ";
          "reference" = "󰌹 ";
          "snippet" = " ";
          "struct" = " ";
          "text" = "";
          "typeParameter" = " ";
          "unit" = " ";
          "value" = "󰎠 ";
          "variable" = " ";
        };
        "diagnostic.checkCurrentLine" = true;
        "diagnostic.errorSign" = "";
        "diagnostic.hintSign" = "";
        "diagnostic.infoSign" = "󰋽";
        "diagnostic.warningSign" = "󱐋";
        "diagnostic.virtualText" = true;
        "diagnostic.virtualTextPrefix" = "-> ";
        "diagnostic.refreshOnInsertMode" = true;
        "list.nextKeymap" = "<C-j>";
        "list.previewHighlightGroup" = "Statement";
        "list.previousKeymap" = "<C-k>";
        "list.signOffset" = 1;
        "yaml.format.enable" = true;
        "signature.target" = "float";
        "typescript.suggestionActions.enabled" = true;
        "python.formatting.provider" = "yapf";
        "python.formatting.yapfArgs" = [
          "--style"
          "{SPACES_AROUND_POWER_OPERATOR = True, SPACES_BEFORE_COMMENT = 1}"
        ];
        "html.autoClosingTags" = true;
        "html.format.enable" = true;
        "javascript.showUnused" = true;
        "javascript.suggest.names" = true;
        "javascript.suggestionActions.enabled" = true;
        "json.format.enable" = true;
        "clangd.arguments" = [
          "--fallback-style=Google"
        ];
        "colors.enable" = true;
        "translator.proxy" = "http://127.0.0.1:7890";
        "Lua.misc.parameters" = [
          "--locale=zh-cn"
        ];
        "Lua.diagnostics.globals" = [
          "vim"
        ];
        "Lua.workspace.library" = [
          "${config.programs.neovim.finalPackage}/share/nvim/runtime/lua"
          "${config.programs.neovim.finalPackage}/share/nvim/runtime/lua/vim"
          "${config.programs.neovim.finalPackage}/share/nvim/runtime/lua/vim/lsp"
        ];
        "Lua.hint.enable" = true;
        "Lua.codeLens.enable" = false;
        "csharp-ls.path" = "/home/${info.username}/.dotnet/tools/csharp-ls";
        "snippets.ultisnips.pythonPrompt" = false;
        "nil.formatting.command" = [ "nixpkgs-fmt" ];
        "go.goplsPath" = "gopls";
      };
    };
  };
}
