{
  lib,
  dots,
  ...
}:
{
  vim = {
    languages = {
      enableFormat = true;
      enableTreesitter = true;
      clang.enable = true;
      bash.enable = true;
      html.enable = true;
      lua.enable = true;
      markdown = {
        enable = true;
        extensions.render-markdown-nvim.enable = true;
        format.enable = true;
        lsp.enable = true;
        treesitter.enable = true;
      };
      nix = {
        enable = true;
        format.type = "nixfmt";
        lsp = {
          server = "nixd";
          options = lib.mkIf (dots != null) {
            nixos = {
              expr = "(builtins.getFlake \"${dots}\").nixosConfigurations.desktop.options";
            };
            home-manager = {
              expr = "(builtins.getFlake \"${dots}\").homeConfigurations.desktop.options";
            };
          };
        };
      };
      rust.enable = true;
    };
    lsp = {
      enable = true;
      formatOnSave = true;
      # lightbulb.enable = true;
      lspkind.enable = false;
      otter-nvim.enable = false; # provide lsp for embedded languages
      trouble.enable = false;
      # lspSignature?
      # mappings?
      mappings = {
        goToDefinition = "gd";
      };
    };
    treesitter = {
      autotagHtml = true;
      fold = true;
    };
  };
}
