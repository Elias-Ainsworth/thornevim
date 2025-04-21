{
  lib,
  pkgs,

  colorscheme,
  transparent,
  variant,
  ...
}:
let
  isKanagawa = colorscheme == "kanagawa";
  isTokyodark = colorscheme == "tokyodark";
  isLucy = colorscheme == "oh-lucy";
  isMinimal = colorscheme == "minimal";
  isAquarium = colorscheme == "aquarium";
  isAshen = colorscheme == "ashen";
  isParadise = colorscheme == "paradise";
  themeConfig = {
    name = if isParadise then "base16" else colorscheme;
    style = variant;
    transparent = transparent;
  };
  kanagawaTransparent = # lua
    ''
      require("kanagawa").setup({
          transparent = true,
          theme = "${variant}",
          colors = {
              all = { ui = { bg_gutter = "none" } },
          },
          overrides = function(colors)
              local theme = colors.theme
              return {
                  DiagnosticSignError = { bg = "none" },
                  DiagnosticSignWarn = { bg = "none" },
                  DiagnosticSignInfo = { bg = "none" },
                  DiagnosticSignHint = { bg = "none" },

                  EndOfBuffer = { bg = "none" },

                  FloatBorder = { bg = "none" },
                  FloatFooter = { bg = "none" },
                  FloatTitle = { bg = "none" },

                  GitSignsAdd = { bg = "none" },
                  GitSignsChange = { bg = "none" },
                  GitSignsDelete = { bg = "none" },

                  LineNr = { bg = "none" },
                  LineNrAbove = { bg = "none" },
                  LineNrBelow = { bg = "none" },

                  MiniFilesTitle = { bg = "none" },
                  MiniFilesTitleFocused = { bg = "none" },

                  MiniPickPrompt = { bg = "none" },

                  MiniStatuslineFilename = { bg = "none" },

                  MiniTablineFill = { bg = "none" },
                  MiniTablineVisible = { bg = "none" },

                  NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
                  NormalFloat = { bg = "none" },

                  Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = vim.o.pumblend },
                  PmenuSbar = { bg = "NONE" },
                  PmenuSel = { fg = "NONE", bg = "NONE" },
                  PmenuThumb = { bg = "NONE" },

                  SignColumn = { bg = "none" },
                  StatusLine = { bg = "none" },
                  StatusLineNC = { bg = "none" },

                  Tabline = { bg = "none" },
                  TablineFill = { bg = "none" },
              }
          end,
      })
      vim.cmd("colorscheme kanagawa-${variant}")
    '';
  kanagawaNonTransparent = "vim.cmd(\"colorscheme kanagawa-${variant}\")";
  base16Paradise = {
    base00 = "111111";
    base01 = "151515";
    base02 = "1F1F1F";
    base03 = "2E2E2E";
    base04 = "424242";
    base05 = "BBB6B6";
    base06 = "E8E3E3";
    base07 = "E8E3E3";
    base08 = "B66467";
    base09 = "D9BC8C";
    base0A = "D9BC8C";
    base0B = "8C977D";
    base0C = "8AA6A2";
    base0D = "8DA3B9";
    base0E = "A988B0";
    base0F = "BBB6B6";
  };
in
{
  vim = {
    theme = lib.mkIf (!isKanagawa && !isTokyodark && !isLucy && !isMinimal && !isAquarium && !isAshen) {
      enable = true;
      transparent = themeConfig.transparent;
      name = themeConfig.name;
      style = themeConfig.style;
      base16-colors = lib.mkIf (isParadise) base16Paradise;
    };

    extraPlugins = with pkgs; {
      kanagawa = lib.mkIf isKanagawa {
        package = vimPlugins.kanagawa-nvim;
        setup = if transparent then kanagawaTransparent else kanagawaNonTransparent;
      };
      oh-lucy = lib.mkIf isLucy {
        package = pkgs.vimUtils.buildVimPlugin {
          name = "vim-oh-lucy";
          src = pkgs.fetchFromGitHub {
            owner = "yazeed1s";
            repo = "oh-lucy.nvim";
            rev = "2d94e9b03efe4c50f4653b6f2b7b200d970fe1aa";
            hash = "sha256-tH44CJnx/ZVwD+U9V7gDVjAjGCQtcnKDxVnVd+vkLz0=";
          };
        };
        setup = # lua
          ''vim.cmd("colorscheme oh-lucy") '';
      };
      tokyodark = lib.mkIf isTokyodark {
        package = pkgs.vimUtils.buildVimPlugin {
          name = "vim-tokyodark";
          src = pkgs.fetchFromGitHub {
            owner = "tiagovla";
            repo = "tokyodark.nvim";
            rev = "cc70a2fb809d5376f2bd8e5836f9bb3f5fb8ef43";
            hash = "sha256-pEnA8s1666HYnHkpN1Xtni+W8vVy+AeUr5z7WY2RLo4=";
          };
        };
        setup = # lua
          if transparent then # lua
            ''
              require("tokyodark").setup({
                  transparent_background = true,
              })
              vim.cmd("colorscheme tokyodark")

            ''
          else
            # lua
            ''vim.cmd("colorscheme tokyodark") '';
      };
      minimal = lib.mkIf isMinimal {
        package = pkgs.vimUtils.buildVimPlugin {
          name = "vim-minimal";
          src = pkgs.fetchFromGitHub {
            owner = "yazeed1s";
            repo = "minimal.nvim";
            rev = "22d837b814d3bd22625640ef63cc73b8507f291d";
            hash = "sha256-hR4k0lf0dsPKlVJUM/JLmREv9Z1LZoHXJn+3Ox/Okck=";
          };
        };
        setup = # lua
          ''
            vim.cmd("colorscheme minimal")
          '';
      };
      aquarium = lib.mkIf isAquarium {
        package = pkgs.vimUtils.buildVimPlugin {
          name = "vim-aquarium";
          src = pkgs.fetchFromGitHub {
            owner = "FrenzyExists";
            repo = "aquarium-vim";
            rev = "6da0091836f36f82af558f0395ea50fd5a297d6d";
            hash = "sha256-TSzbJ436qn377TTQNNQxoXvhkxIusOsck9ktoVZlg2U=";
          };
        };
        setup = # lua
          if transparent then # lua
            ''
              vim.g.aqua_transparency = 1
              vim.cmd("colorscheme aquarium")
            ''
          else
            # lua
            ''
              vim.cmd("colorscheme aquarium")
            '';
      };
      ashen = lib.mkIf isAshen {
        package = pkgs.vimUtils.buildVimPlugin {
          name = "vim-ashen";
          src = pkgs.fetchFromGitHub {
            owner = "ficcdaf";
            repo = "ashen.nvim";
            rev = "638fbfe0845068cd49a7d6e0c9c1a34e91f899cd";
            hash = "sha256-ZkKetxBkzVuGzuvQqS2hynKxtVqBZpGpxSDVlueD5Ao=";
          };
        };
        setup = # lua
          ''vim.cmd("colorscheme ashen") '';
      };
    };
  };
}
