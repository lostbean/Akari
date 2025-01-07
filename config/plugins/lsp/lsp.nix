{
  plugins = {
    lsp-signature.enable = true;

    lsp = {
      enable = true;
      servers.typos_lsp.enable = true;
      keymaps = {

        lspBuf = {
          "gh" = "signature_help";
        };
      };
    };

    lint.enable = true;

    which-key.settings.spec = [
      {
        __unkeyed = "gh";
        desc = "Signature Help";
      }
    ];
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>cl";
      action = "<cmd>LspInfo<cr>";
      options.desc = "Lsp Info";
    }
  ];
}
