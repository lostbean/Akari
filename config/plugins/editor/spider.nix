{
  plugins = {
    spider = {
      extraOptions = {
        subwordMovement = false;
      };
      enable = true;
      keymaps = {
        motions = {
          w = "w";
          e = "e";
          b = "b";
          ge = "ge";
        };
      };
    };

    which-key.settings.spec = [
      {
        __unkeyed = "w";
        desc = "Next word (spider)";
      }
      {
        __unkeyed = "e";
        desc = "Next end of word (spider)";
      }
      {
        __unkeyed = "b";
        desc = "Prev word (spider)";
      }
      {
        __unkeyed = "ge";
        desc = "Prev end of word (spider)";
      }
    ];
  };
}
