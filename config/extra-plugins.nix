{
  pkgs,
  ...
}:
{
  vim = {
    extraPlugins = with pkgs.vimPlugins; {
      direnv = {
        package = direnv-vim;
      };
      # oil = {
      #   package = oil-nvim;
      #   setup = # lua
      #     ''
      #       require('oil').setup({
      #               keymaps = {
      #                 ["K"] = "actions.parent",
      #                 ["J"] = "actions.select",
      #               },
      #             })
      #     '';
      # };
      rooter = {
        package = vim-rooter;
      };
      vim-tmux-navigator = {
        package = vim-tmux-navigator;
      };
    };
  };
}
