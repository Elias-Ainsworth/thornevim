{
  pkgs,
  inputs,
  colorscheme ? "oxocarbon",
  maxi ? false,
  transparency ? false,
  dots ? "/persist/home/elias-ainsworth/projects/dotfiles",
  outputs ? null,
}:
let
  neovimConfig = inputs.nvf.lib.neovimConfiguration {
    inherit pkgs;
    modules = [ (import ../config) ];
    extraSpecialArgs = {
      # Inputs is seemingly reserved, though the docs don't show it
      inputs' = inputs;
      inherit
        colorscheme
        maxi
        transparency
        dots
        outputs
        ;
    };
  };
in
# Explicitly return the neovim package
neovimConfig.neovim
