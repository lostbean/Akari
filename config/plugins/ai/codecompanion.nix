{
  plugins.codecompanion = {
    enable = true;

    settings = {
      adapters = {
        anthropic = "anthropic";
      };

      strategies = {
        chat.adapter = "anthropic";
        inline.adapter = "anthropic";
        agent.adapter = "anthropic";
      };

      prompt_library = {
        "Describe PR" = {
          strategy = "chat";
          description = "Create a PR description between the current brancn and main";
          opts = {
            index = 5;
            is_default = true;
            is_slash_cmd = false;
            auto_submit = true;
            user_prompt = false;
            stop_context_insertion = true;
          };
          prompts = [
            {
              role = "user";
              content.__raw = ''
                function()
                  return string.format(
                    [[
                    Generated a PR description based on:
                    ```diff
                    %s
                    ```

                    and based on these commint messages:
                    %s
                    ]],
                    vim.fn.system("git diff $(git merge-base --fork-point main)"),
                    vim.fn.system("git log ...main --oneline --no-merges")
                  )
                end
              '';
              opts = {
                visible = false;
                tag = "system_tag";
              };
            }
          ];
        };
      };
      opts = {
        log_level = "TRACE";
        send_code = true;
        use_default_actions = true;
        use_default_prompts = true;
      };
    };
  };

  keymaps = [
    {
      action = "<cmd>CodeCompanionActions<CR>";
      key = "<leader>ac";
      options.desc = "CodeCompanion Actions";
      mode = [
        "v"
        "n"
      ];
    }
  ];
}
