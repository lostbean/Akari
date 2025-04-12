{ pkgs, ... }:
{
  plugins = {

    lsp = {
      servers.elixirls = {
        enable = true;
        cmd = [
          "elixir-ls"
        ];
      };
    };
  };

  extraConfigLua = ''
    -- -- Elixir LSP
    -- require("lspconfig").elixirls.setup({
    --   cmd = { "elixir-ls" };
    --   flags = {
    --     debounce_text_changes = 150,
    --   },
    --   elixirLS = {
    --     dialyzerEnabled = false,
    --     fetchDeps = false,
    --   };
    -- })
    -- require("lspconfig")["nextls"].setup({
    --   cmd = {"nextls", "--stdio"},
    --   init_options = {
    --     extensions = {
    --       credo = { enable = true }
    --     },
    --     experimental = {
    --       completions = { enable = true }
    --     }
    --   }
    -- })
  '';

  keymaps = [
    {
      mode = [ "n" ];
      action.__raw = ''
        function()
          local params = vim.lsp.util.make_position_params()
          LazyVim.lsp.execute({
            command = "manipulatePipes:serverid",
            arguments = { "toPipe", params.textDocument.uri, params.position.line, params.position.character };
          })
        end
      '';
      key = "<leader>cp";
      options = {
        desc = "To Pipe";
      };
    }
    {
      mode = [ "n" ];
      action.__raw = ''
        function()
          local params = vim.lsp.util.make_position_params()
          LazyVim.lsp.execute({
            command = "manipulatePipes:serverid",
            arguments = { "fromPipe", params.textDocument.uri, params.position.line, params.position.character },
          })
        end
      '';
      key = "<leader>cP";
      options = {
        desc = "From Pipe";
      };
    }
  ];
}
