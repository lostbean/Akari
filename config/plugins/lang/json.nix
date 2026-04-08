{ pkgs, lib, ... }:
{
  plugins = {
    conform-nvim.settings = {
      formatters_by_ft = {
        json = [ "jq" ];
      };

      formatters = {
        jq = {
          command = lib.getExe pkgs.jq;
        };
      };
    };

    lsp.servers.jsonls = {
      enable = true;
    };
  };
}
