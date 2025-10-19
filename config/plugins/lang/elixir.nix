{ pkgs, ... }:
{
  plugins = {

    lsp = {
      servers.expert = {
        enable = true;
        cmd = [ "expert" ];
        # root-markers = [
        #   "mix.exs"
        #   ".git"
        # ];
        filetypes = [
          "elixir"
          "eelixir"
          "heex"
        ];
      };
    };

    conform-nvim.settings = {
      formatters_by_ft = {
        elixir = [ "mix" ];
      };
    };

  };

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
