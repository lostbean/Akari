{ pkgs, ... }:
{
  extraPlugins = builtins.trace "${pkgs.mcphub-nvim}" [ pkgs.mcphub-nvim ];

  extraConfigLua = ''
    require("mcphub").setup({
        port = 6000,
        config = vim.fn.expand("~/mcp-hub/mcp-servers.json"),
        cmd = "${pkgs.mcphub}/bin/mcp-hub"
    })
  '';
}
