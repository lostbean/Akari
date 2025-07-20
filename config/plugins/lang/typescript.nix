{ pkgs, lib, ... }:
{

  plugins = {
    conform-nvim.settings = {
      formatters_by_ft = {
        javascript = [ "prettierd" ];
        javascriptreact = [ "prettierd" ];
        typescript = [ "prettierd" ];
        typescriptreact = [ "prettierd" ];
        svelte = [ "prettierd" ];
      };

      formatters.eslint_d = {
        command = lib.getExe pkgs.prettierd;
      };
    };

    typescript-tools = {
      enable = true;

      settings = {
        settings = {
          code_lens = "off";
          complete_function_calls = false;
          disable_member_code_lens = true;
          expose_as_code_action = "all";
          include_completions_with_insert_text = true;
          publish_diagnostic_on = "insert_leave";
          separate_diagnostic_server = true;
          tsserver_locale = "en";
          tsserver_max_memory = "auto";
          tsserver_path = "${pkgs.typescript}/lib/node_modules/typescript/lib/tsserver.js";
          jsx_close_tag = {
            enable = false;
            filetypes = [
              "javascriptreact"
              "typescriptreact"
            ];
          };
        };
      };
    };

    lsp.servers = {
      svelte.enable = true;

      eslint = {
        enable = true;
        filetypes = [
          "javascript"
          "javascriptreact"
          "javascript.jsx"
          "typescript"
          "typescriptreact"
          "typescript.tsx"
          "vue"
          "html"
          "markdown"
          "json"
          "jsonc"
          "yaml"
          "toml"
          "xml"
          "gql"
          "graphql"
          "svelte"
          "css"
          "less"
          "scss"
          "pcss"
          "postcss"
        ];
      };
    };

    ts-autotag.enable = true;
  };
}
