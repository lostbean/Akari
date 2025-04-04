{
  plugins = {
    copilot-chat.enable = true;
    copilot-lua = {
      enable = true;
      settings = {
        suggestion = {
          enabled = false;
          autoTrigger = true;
          keymap.accept = "<C-CR>";
        };
        panel.enabled = false;
      };
    };

    which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>a";
        mode = "n";
        icon = "󰚩";
        group = "+ai";
      }
    ];
  };

  keymaps = [
    {
      action = "<cmd>CopilotChatToggle<CR>";
      key = "<leader>ap";
      options.desc = "Toggle Coilot chat";
      mode = "n";
    }
  ];
}
