{
  lib,
  transparent,
  ...
}:
{
  vim = {
    autocomplete.blink-cmp = {
      enable = true;
      friendly-snippets.enable = true;
      mappings = {
        next = "<C-n>";
        previous = "<C-p>";
      };
      setupOpts = {
        keymap.preset = "enter";
        cmdline.keymap.preset = "default";
        completion = {
          list.selection.preselect = false;
          menu.auto_show = true;
        };
      };
    };
    binds.whichKey = {
      enable = true;
      register = {
        "<leader>c" = "Choose [Gitsigns]";
        "<leader>g" = "Git";
        "<leader>l" = "Lsp";
        "<leader>lg" = "Go-to";
        "<leader>lt" = "Toggle";
        "<leader>lw" = "Workspace";
        # "<leader>o" = "Oil";
        "<leader>t" = "Toggle [Gitsigns]";
      };
      setupOpts = {
        preset = "helix";
      };
    };
    formatter.conform-nvim.enable = true;
    mini = {
      ai.enable = true;
      bracketed.enable = true;
      bufremove.enable = true;
      comment.enable = true;
      extra.enable = true;
      files.enable = false;
      indentscope.enable = true;
      jump.enable = true;
      move.enable = true;
      notify = {
        enable = true;
        setupOpts = lib.mkIf transparent {
          window.winblend = 0;
        };
      };
      operators.enable = true;
      pairs.enable = true;
      splitjoin.enable = true;
      starter = {
        enable = true;
        setupOpts = {
          header = builtins.readFile ../assets/ascii/neovim.txt;
          # footer = "#[derive(Dumb)]";
          footer = ''
            「僕はエリアス・エインズワースかもしれないが、
                      チセがいない――つまり、僕は完全に『チセレス』だ。」'';
        };

      };
      surround.enable = true;
      trailspace.enable = true;
    };
    notes.todo-comments = {
      enable = true;
      mappings = {
        telescope = "<leader>fc";
      };
    };
    presence.neocord = {
      enable = true;
      setupOpts = {
        logo = "https://raw.githubusercontent.com/Elias-Ainsworth/thornevim/refs/heads/main/assets/icons/nvf.png";
      };
    };
    snippets.luasnip.enable = true;
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
    telescope = {
      enable = true;
      mappings = {
        buffers = "<leader>fb";
        findFiles = "<leader>ff";
        liveGrep = "<leader>/";
      };
      setupOpts = {
        defaults = {
          mappings = {
            i."<S-BS>" = lib.generators.mkLuaInline "require('telescope.actions').delete_buffer";
            n."dd" = lib.generators.mkLuaInline "require('telescope.actions').delete_buffer";
          };
        };
      };
    };
    ui = {
      colorizer.enable = true;
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
