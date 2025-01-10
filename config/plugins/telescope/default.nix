{ pkgs, ... }:
{
  plugins = {
    project-nvim.enableTelescope = true;
    telescope = {
      enable = true;
      extensions = {
        fzf-native.enable = true;
        undo.enable = true;
        ui-select = {
          settings = {
            specific_opts = {
              codeactions = true;
            };
          };
        };
      };

      settings.defaults = {
        prompt_prefix = "   ";
        color_devicons = true;
        set_env.COLORTERM = "truecolor";

        mappings = {
          i = {
            # Have Telescope not to enter a normal-like mode when hitting escape (and instead exiting), you can map <Esc> to do so via:
            "<esc>".__raw = ''
              function(...)
                return require("telescope.actions").close(...)
              end'';
            "<c-t>".__raw = ''
              function(...)
                require('trouble.providers.telescope').open_with_trouble(...);
              end
            '';
          };
          n = {
            "<c-t>".__raw = ''
              function(...)
                require('trouble.providers.telescope').open_with_trouble(...);
              end
            '';
          };
        };
        # trim leading whitespace from grep
        vimgrep_arguments = [
          "${pkgs.ripgrep}/bin/rg"
          "--color=never"
          "--no-heading"
          "--with-filename"
          "--line-number"
          "--column"
          "--smart-case"
          "--trim"
        ];
      };
      keymaps = {
        "<leader>fp" = {
          action = "projects";
          options.desc = "Search Todo";
        };
        "<leader>st" = {
          action = "todo-comments";
          options.desc = "Search Todo";
        };
        "<leader>sn" = {
          action = "notify";
          options.desc = "Search Notifications";
        };
        "<leader>su" = {
          action = "undo";
          options.desc = "Search Undo";
        };
        "<leader><space>" = {
          action = "find_files";
          options.desc = "Find project files";
        };
        "<leader>ff" = {
          action = "find_files hidden=true";
          options.desc = "Find project files";
        };
        "<leader>fg" = {
          action = "git_files";
          options.desc = "Git Files";
        };
        "<leader>/" = {
          action = "live_grep";
          options.desc = "Grep (project root)";
        };
        "<leader>:" = {
          action = "command_history";
          options.desc = "Command History";
        };
        "<leader>fr" = {
          action = "oldfiles";
          options.desc = "Recent";
        };
        "<c-p>" = {
          mode = [
            "n"
            "i"
          ];
          action = "registers";
          options.desc = "Select register to paste";
        };
        "<leader>gc" = {
          action = "git_commits";
          options.desc = "commits";
        };
        "<leader>sa" = {
          action = "autocommands";
          options.desc = "Auto Commands";
        };
        "<leader>sc" = {
          action = "commands";
          options.desc = "Commands";
        };
        "<leader>sd" = {
          action = "diagnostics bufnr=0";
          options.desc = "Workspace diagnostics";
        };
        "<leader>sh" = {
          action = "help_tags";
          options.desc = "Help pages";
        };
        "<leader>sk" = {
          action = "keymaps";
          options.desc = "Key maps";
        };
        "<leader>sM" = {
          action = "man_pages";
          options.desc = "Man pages";
        };
        "<leader>sm" = {
          action = "marks";
          options.desc = "Jump to Mark";
        };
        "<leader>so" = {
          action = "vim_options";
          options.desc = "Options";
        };
        "<leader>uC" = {
          action = "colorscheme";
          options.desc = "Colorscheme preview";
        };
        "<leader>fu" = {
          mode = "n";
          action = "undo";
          options.desc = "List undo history";
        };
      };
    };
  };

  keymaps = [
    {
      key = "<leader>sg";
      action.__raw = ''
        function()
          local opts = {}
          local git_dir = vim.fn.system(string.format("${pkgs.git}/bin/git -C %s rev-parse --show-toplevel 2>/dev/null", vim.fn.expand("%:p:h")))
          if vim.v.shell_error == 0 then
            git_dir = string.gsub(git_dir, "\n", "") -- remove newline character
            opts = {
              cwd = git_dir,
              prompt_title = "Live Grep (Git Root)"
            }
          end
          require('telescope.builtin').live_grep(opts)
        end
      '';
      options.desc = "Grep (Git root)";
    }
  ];
}
