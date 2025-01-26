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

    extraOptions.commands = {
      copy_path.__raw = ''
        function(state)
          -- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
          -- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
          local node = state.tree:get_node()
          local filepath = node:get_id()
          local filename = node.name
          local modify = vim.fn.fnamemodify

          local results = {
            filepath,
            modify(filepath, ':.'),
            modify(filepath, ':~'),
            filename,
            modify(filename, ':r'),
            modify(filename, ':e'),
          }

          vim.ui.select({
            '1. Absolute path: ' .. results[1],
            '2. Path relative to CWD: ' .. results[2],
            '3. Path relative to HOME: ' .. results[3],
            '4. Filename: ' .. results[4],
            '5. Filename without extension: ' .. results[5],
            '6. Extension of the filename: ' .. results[6],
          }, { prompt = 'Choose to copy to clipboard:' }, function(choice)
            local i = tonumber(choice:sub(1, 1))
            local result = results[i]
            vim.fn.setreg('*', result)
            vim.notify('Copied: ' .. result)
          end)
        end
      '';
    };

    window.mappings = {
      "<space>" = "none";
      "l" = "open";
      "h" = "close_node";
      "y" = "copy_path";
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
      action = "<cmd>Neotree float source=git_status action=focus reveal toggle<cr>";
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
