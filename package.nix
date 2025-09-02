{
  inputs,
  pkgs,

  colorscheme ? "oxocarbon",
  dots ? null,
  outputs ? null,
  transparent ? false,
  variant ? "dark",
}:
let
  neovimConfig = inputs.nvf.lib.neovimConfiguration {
    inherit pkgs;
    modules = [ (inputs.import-tree ../config) ];
    extraSpecialArgs = {
      # Inputs is seemingly reserved, though the docs don't show it
      inputs' = inputs;
      libCustom = import ./lib.nix;
      inherit
        colorscheme
        dots
        outputs
        transparent
        variant
        ;
    };
  };
in

# Explicitly return the neovim package
neovimConfig.neovim
