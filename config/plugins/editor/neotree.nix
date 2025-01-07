{ icons, ... }:
{
  plugins.neo-tree = {
    enable = true;

    closeIfLastWindow = true;

    autoCleanAfterSessionRestore = true;

    sources = [
      "filesystem"
      "buffers"
      "git_status"
      "document_symbols"
    ];

    popupBorderStyle = "rounded"; # “NC”, “double”, “none”, “rounded”, “shadow”, “single”, “solid” or raw lua code

    filesystem = {
      bindToCwd = false;
      useLibuvFileWatcher = true;
      followCurrentFile.enabled = true;

      filteredItems = {
        hideDotfiles = false;
        hideHidden = false;

        neverShowByPattern = [
          ".direnv"
          ".git"
        ];

        visible = true;
      };
    };

    eventHandlers = {
      # Close neotree after opening a file
      "file_open_requested" = ''
        function()
          require("neo-tree.command").execute({ action = "close" })
        end
      '';
    };

    defaultComponentConfigs = {
      gitStatus = {
        symbols = {
          added = icons.git.LineAdded;
          conflict = icons.git.FileConflict;
          deleted = icons.git.FileDeleted;
          ignored = icons.git.FileIgnored;
          modified = icons.git.LineModified;
          renamed = icons.git.FileRenamed;
          staged = icons.git.FileStaged;
          unstaged = icons.git.FileUnstaged;
          untracked = icons.git.FileUntracked;
        };
      };
    };

    window.mappings = {
      "<space>" = "none";
      "l" = "open";
      "h" = "close_node";
      "P".__raw = ''{ "toggle_preview", config = { use_float = true } }'';
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>e";
      action = "<cmd>Neotree action=focus reveal toggle<cr>";
      options = {
        silent = true;
        desc = "Explorer NeoTree (root dir)";
      };
    }

    {
      mode = "n";
      key = "<leader>ge";
      action = "<cmd>Neotree source=git_status action=focus reveal toggle<cr>";
      options = {
        silent = true;
        desc = "Explorer NeoTree (git modified)";
      };
    }

    {
      mode = "n";
      key = "<leader>be";
      action = "<cmd>Neotree source=buffers action=focus reveal toggle<cr>";
      options = {
        silent = true;
        desc = "Explorer NeoTree (open buffers)";
      };
    }
  ];
}
