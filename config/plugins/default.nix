{
  imports = [
    ./ai/avante.nix
    ./ai/codecompanion.nix
    ./ai/copilot.nix
    ./ai/mcphub.nix

    ./completion/cmp.nix
    ./completion/lspkind.nix
    ./completion/friendly-snippets.nix

    ./debug/dap.nix

    ./editor/lz-n.nix
    ./editor/neotree.nix
    ./editor/spider.nix
    ./editor/undotree.nix
    ./editor/multicursor.nix
    ./editor/whichkey.nix
    ./editor/yanky.nix
    ./editor/yazi.nix

    ./theme
    ./luasnip
    ./telescope

    ./snacks

    ./git/gitsigns.nix

    ./lsp/conform.nix
    ./lsp/fastaction.nix
    # ./lsp/fidget.nix
    ./lsp/lsp.nix
    ./lsp/lspsaga.nix
    ./lsp/trouble.nix

    ./lang/cpp.nix
    ./lang/css.nix
    ./lang/docker.nix
    ./lang/elixir.nix
    ./lang/html.nix
    ./lang/json.nix
    ./lang/lua.nix
    ./lang/markdown.nix
    ./lang/nix.nix
    ./lang/python.nix
    ./lang/shell.nix
    ./lang/typescript.nix
    ./lang/yaml.nix
    ./lang/gleam.nix

    ./treesitter/treesitter.nix
    ./treesitter/treesitter-textobjects.nix

    ./ui/alpha.nix
    ./ui/bufferline.nix
    ./ui/general.nix
    ./ui/flash.nix
    ./ui/indent-blankline.nix
    ./ui/lualine.nix
    ./ui/noice.nix
    ./ui/notify.nix
    ./ui/nui.nix
    ./ui/precognition.nix
    ./ui/toggleterm.nix
    ./ui/ufo.nix

    ./util/colorizer.nix
    ./util/compiler.nix
    ./util/debugprint.nix
    ./util/kulala.nix
    ./util/mini.nix
    # ./util/nvim-colorizer.nix
    ./util/nvim-autopairs.nix
    ./util/mini-surround.nix
    ./util/plenary.nix
    ./util/persistence.nix
    ./util/project-nvim.nix
    ./util/package-info.nix
  ];
}
