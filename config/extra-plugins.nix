{
  pkgs,
  ...
}:
{
  vim = {
    extraPlugins = with pkgs.vimPlugins; {
      rooter = {
        package = vim-rooter;
      };
      vim-tmux-navigator = {
        package = vim-tmux-navigator;
      };
    };
  };
}
