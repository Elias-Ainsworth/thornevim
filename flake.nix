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
                # Git
                deadnix
                nixfmt-rfc-style
                pre-commit
                statix

                # LSP
                lua-language-server
                nixd
              ];
            };
          };
          packages = rec {
            default = thornevim;
            thornevim = pkgs.callPackage ./pkgs/nvf-config.nix { inherit inputs; };
            everforest = thornevim.override {
              colorscheme = "everforest";
              transparent = true;
            };
          };
        };
    };
}
