{
  pkgs,
  ...
}:
{
  vim = {
    extraPlugins = with pkgs.vimPlugins; {
      overseer = {
        package = overseer-nvim;
        setup =
          # lua
          ''require('overseer').setup()'';
      };
      rooter = {
        package = vim-rooter;
      };
      vim-tmux-navigator = {
        package = vim-tmux-navigator;
      };
    };
  };
}
