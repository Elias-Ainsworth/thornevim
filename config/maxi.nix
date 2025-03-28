{
  lib,
  pkgs,
  maxi ? false,
  ...
}:
{
  vim = lib.mkIf maxi {
    dashboard = {
      startify = {
        enable = true;
        changeToVCRoot = true;
        customHeader = [
          #TODO: Make this say eepyVim
          "                                                                       "
          "                                                                     "
          "       ████ ██████           █████      ██                     "
          "      ███████████             █████                             "
          "      █████████ ███████████████████ ███   ███████████   "
          "     █████████  ███    █████████████ █████ ██████████████   "
          "    █████████ ██████████ █████████ █████ █████ ████ █████   "
          "  ███████████ ███    ███ █████████ █████ █████ ████ █████  "
          " ██████  █████████████████████ ████ █████ █████ ████ ██████ "
          "                                                                       "
        ];
      };
    };
    extraPlugins = {
      oil = with pkgs.vimPlugins; {
        package = oil-nvim;
        setup = # lua
          ''
            require('oil').setup({
                    keymaps = {
                      ["K"] = "actions.parent",
                      ["J"] = "actions.select",
                    },
                  })
          '';
      };
    };
    autopairs.nvim-autopairs.enable = true;
    binds.whichKey = {
      enable = true;
      register = {
        # Leader
        #TODO: Set <leader>a to not show when the option is available.
        # "<leader>a" = "";
        "<leader>gc" = "+Conflict";
        "<leader>gd" = "+Diff";
        "<leader>gr" = "+Reset";
        "<leader>gs" = "+Stage";
        "<leader>gt" = "+Toggle";
        "<leader>G" = "+Git";
        "<leader>l" = "+LSP";
        "<leader>n" = "+Neorg";
        "<leader>nw" = "+Workspaces";
        "<leader>o" = "+Oil";
        "<leader>t" = "+Todo";
        # Local Leader
        ",c" = "+Code";
        ",i" = "+Insert";
        ",l" = "+List";
        ",n" = "+Note";
        ",t" = "+Todo";
      };
      setupOpts = {
        preset = "helix";
      };
    };
    comments.comment-nvim.enable = true;
    snippets.luasnip.enable = true;
    statusline.lualine.enable = true;
    tabline.nvimBufferline = {
      enable = true;
      setupOpts = {
        options = {
          numbers = "none";
          show_close_icon = false;
        };
      };
    };
    telescope = {
      enable = true;
      mappings = {
        buffers = "<leader>fb";
        findFiles = "<leader>ff";
        gitBranches = "<leader>gb";
        gitStatus = "<leader>gT";
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
    ui.colorizer.enable = true;
    utility = {
      motion.leap.enable = true;
      # preview.markdownPreview.enable = true;
      surround.enable = true;
    };
    visuals.nvim-web-devicons.enable = true;
  };
}
