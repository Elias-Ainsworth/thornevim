{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    systems.url = "github:nix-systems/default-linux";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs =
    inputs@{
      flake-parts,
      nixpkgs,
      self,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;
      perSystem =
        { pkgs, ... }:
        {
          devShells = {
            default = pkgs.mkShell {
              packages = with pkgs; [
                nixd
                nixfmt-rfc-style
                statix
                lua-language-server
              ];
            };
          };
          packages = rec {
            thornevim = pkgs.callPackage ./pkgs/nvf-config.nix { };
            default = thornevim;
            
            # Override examples
            oxocarbon = thornevim.override { colorscheme = "oxocarbon"; };
            kanagawa = thornevim.override { colorscheme = "kanagawa"; };
            kanagawa-transparent = thornevim.override {
              colorscheme = "kanagawa";
              transparency = true;
            };
            transparent = thornevim.override {
              transparency = true;
            };
            thorneos = thornevim.override { 
              dots = "/persist/home/elias-ainsworth/projects/dotfiles"; 
            };
            thorneos-kanagawa = thornevim.override {
              dots = "/persist/home/elias-ainsworth/projects/dotfiles";
              colorscheme = "kanagawa";
            };
            thorneos-oxocarbon = thornevim.override {
              dots = "/persist/home/elias-ainsworth/projects/dotfiles";
              colorscheme = "oxocarbon";
            };
            thorneos-kanagawa-transparent = thornevim.override {
              dots = "/persist/home/elias-ainsworth/projects/dotfiles";
              colorscheme = "kanagawa";
              transparency = true;
            };
            thorneos-transparent = thornevim.override {
              dots = "/persist/home/elias-ainsworth/projects/dotfiles";
              transparency = true;
            };
          };
        };
    };
}
