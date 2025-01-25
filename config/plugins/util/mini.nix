{
  plugins = {
    mini = {
      enable = true;
      modules = {
        comment = {
          options = {
            customCommentString = ''
              <cmd>lua require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring<cr>
            '';
          };
        };
        # Highlight word under cursor
        cursorword = {
          delay = 0;
        };

        # Show indent lines
        indentscope = {
          symbol = "│";
          draw.delay = 0;
        };

        ai = {
          custom_textobjects = {
            # NOTE: adding which-key maps would requere much more complex workaround: https://github.com/echasnovski/mini.nvim/issues/192
            g.__raw = ''
              function()
                local from = { line = 1, col = 1 }
                local to = {
                  line = vim.fn.line('$'),
                  col = math.max(vim.fn.getline('$'):len(), 1)
                }
                return { from = from, to = to }
              end
            '';
          };
        };
      };
    };

    ts-context-commentstring.enable = true;
  };
}
