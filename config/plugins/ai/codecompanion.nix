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
