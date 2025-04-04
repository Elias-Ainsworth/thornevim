{
  lib,
  ...
}:
{
  vim = {
    autocomplete.blink-cmp = {
      enable = true;
      friendly-snippets.enable = true;
      # mappings = {
      #   next = "<C-n>";
      #   previous = "<C-p>";
      # };
      setupOpts = {
        # completion.menu.winblend = if transparent then 100 else 0;
        keymap = {
          preset = "none";
          "<M-space>" = [
            "show"
            "show_documentation"
            "hide_documentation"
          ];
          "<C-e>" = [
            "hide"
            "fallback"
          ];
          "<Tab>" = [
            (lib.generators.mkLuaInline ''
              function(cmp)
                  if cmp.snippet_active() then return cmp.accept()
                  else return cmp.select_and_accept() end
                end'')
            "snippet_forward"
            "fallback"
          ];
          "<S-Tab>" = [
            "snippet_backward"
            "fallback"
          ];
          "<Up>" = [
            "select_prev"
            "fallback"
          ];
          "<Down>" = [
            "select_next"
            "fallback"
          ];
          "<C-p>" = [
            "select_prev"
            "fallback_to_mappings"
          ];
          "<C-n>" = [
            "select_next"
            "fallback_to_mappings"
          ];
          "<C-u>" = [
            "scroll_documentation_up"
            "fallback"
          ];
          "<C-d>" = [
            "scroll_documentation_down"
            "fallback"
          ];
          "<C-k>" = [
            "show_signature"
            "hide_signature"
            "fallback"
          ];
        };
      };
    };
    formatter.conform-nvim.enable = true;
    navigation.harpoon = {
      enable = true;
      mappings = {
        file1 = "<M-n>";
        file2 = "<M-e>";
        file3 = "<M-i>";
        file4 = "<M-o>";
        listMarks = "<M-t>";
        markFile = "<M-s>";
      };
    };
    notes.todo-comments = {
      enable = true;
      mappings = {
        telescope = "<leader>tt";
        trouble = "<leader>tr";
        quickFix = "<leader>tq";
      };
    };
    presence.neocord = {
      enable = true;
    };
    projects.project-nvim = {
      enable = true;
      setupOpts = {
        detection_methods = [
          "lsp"
          "pattern"
        ];
        patterns = [
          "=.envrc"
          "=flake.nix"
          "=.norg"
          ">projects/"
          ">playground/"
        ];
      };
    };
    statusline.lualine = {
      enable = true;
      setupOpts = {
        options = {
          icons_enabled = true;
          theme = "auto";
          disabled_filetypes = {
            statusline = [ "ministarter" ];
            winbar = [ "ministarter" ];
          };
          ignore_focus = { };
          always_divide_middle = true;
          always_show_tabline = true;
          globalstatus = false;
          refresh = {
            statusline = 100;
            tabline = 100;
            winbar = 100;
          };
        };
      };
    };
    tabline.nvimBufferline = {
      enable = true;
      setupOpts.options = {
        numbers = "none";
        show_close_icon = false;
      };
    };
    ui = {
      colorizer = {
        enable = true;
        setupOpts = {
          user_default_options = {
            RGB = true;
            RRGGBB = true;
            RRGGBBAA = true;
            css = true;
            names = false;
            tailwind = true;
          };
        };
      };
      smartcolumn = {
        enable = true;
        setupOpts = {
          disabled_filetypes = [ "ministarter" ];
        };
      };
    };
    utility.preview.markdownPreview.enable = true;
    visuals.nvim-web-devicons.enable = true;
  };
}
