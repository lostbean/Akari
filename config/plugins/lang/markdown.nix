{ pkgs, helpers, ... }:
{
  extraPackages = with pkgs; [
    marksman
  ];

  plugins = {
    clipboard-image = {
      enable = true;
      clipboardPackage = pkgs.wl-clipboard;
    };

    image = {
      enable = helpers.enableExceptInTests;
      settings = {
        integrations.markdown = {
          clearInInsertMode = true;
          onlyRenderImageAtCursor = true;
        };
      };
    };

    markdown-preview = {
      enable = true;
    };

    lsp.servers = {
      marksman.enable = true;

      ltex = {
        enable = true;
        filetypes = [
          "markdown"
          "text"
        ];

        settings.completionEnabled = true;

        extraOptions = {
          checkFrequency = "save";
          language = "en-GB";
        };
      };
    };

    # TODO: Somehow setiing this linter breaks the init.lua with:
    # E5113: Error while calling lua chunk: /nix/store/45qcp4lqkwlqmmc4ivpip1kir0bnfym4-init.lua:797: attempt to index a nil value
    #
    # lint = {
    #   lintersByFt = {
    #     md = [ "mdcli" ];
    #   };
    #
    #   linters = {
    #     mdcli = {
    #       cmd = "${pkgs.markdownlint-cli2}/bin/markdownlint-cli2";
    #     };
    #   };
    # };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>m";
      action = "<cmd>MarkdownPreviewToggle<cr>";
      options = {
        silent = true;
        desc = "Toggle markdown preview";
      };
    }
  ];
}
