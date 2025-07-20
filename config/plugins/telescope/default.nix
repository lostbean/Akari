{ pkgs, ... }:
{
  imports = [
    ./undo.nix
  ];

  plugins = {
    telescope = {
      enable = true;
      highlightTheme = "Catppuccin Macchiato";
      extensions = {
        fzf-native.enable = true;
        ui-select = {
          enable = true;
          settings = {
            __unkeyed-1.__raw = ''require("telescope.themes").get_dropdown{}'';
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
        file_ignore_patterns = [
          "^.git/"
          "^.mypy_cache/"
          "^__pycache__/"
          "^output/"
          "^data/"
          "%.ipynb"
        ];

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
        "<leader>ft" = {
          action = "todo-comments";
          options.desc = "View Todo";
        };
        "<leader><space>" = {
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
        "<leader>f:" = {
          action = "command_history";
          options.desc = "View Command History";
        };
        "<leader>fr" = {
          action = "oldfiles";
          options.desc = "View Recent files";
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
        "<leader>fa" = {
          action = "autocommands";
          options.desc = "Auto Commands";
        };
        "<leader>fc" = {
          action = "commands";
          options.desc = "View Commands";
        };
        "<leader>fd" = {
          action = "diagnostics bufnr=0";
          options.desc = "View Workspace diagnostics";
        };
        "<leader>fh" = {
          action = "help_tags";
          options.desc = "View Help pages";
        };
        "<leader>fk" = {
          action = "keymaps";
          options.desc = "View Key maps";
        };
        "<leader>fm" = {
          action = "man_pages";
          options.desc = "View Man pages";
        };
        "<leader>f'" = {
          action = "marks";
          options.desc = "View Marks";
        };
        "<leader>fo" = {
          action = "vim_options";
          options.desc = "View Options";
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
