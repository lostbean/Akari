{ pkgs, ... }:
{
  plugins = {
    lsp.servers.gleam.enable = true;

    conform-nvim.settings = {
      formatters_by_ft = {
        gleam = [ "gleam" ];
      };

      formatters = {
        gleam = {
          command = "${pkgs.gleam}/bin/gleam";
        };
      };
    };
  };

}
