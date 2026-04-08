{ pkgs, lib, ... }:
{
  lsp.servers.hls = {
    enable = true;
    config.settings.haskell = {
      formattingProvider = "ormolu";
    };
  };

  plugins = {
    conform-nvim.settings = {
      formatters_by_ft.haskell = [ "ormolu" ];
      formatters.ormolu = {
        command = lib.getExe pkgs.ormolu;
      };
    };

    lint = {
      lintersByFt.haskell = [ "hlint" ];
      linters.hlint.cmd = lib.getExe pkgs.hlint;
    };
  };
}
