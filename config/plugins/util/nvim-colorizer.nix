{ mkPkgs, inputs, ... }:
{
  extraPlugins = [
    (mkPkgs "volt" inputs.volt)
    (mkPkgs "minty" inputs.minty)
  ];

  plugins.colorizer = {
    enable = true;
    settings.user_default_options = {
      css = true;
      mode = "virtualtext";
      tailwind = true;
      sass.enable = true;
      virtualtext = "■";
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>uc";
      action = "<cmd>lua require('minty.huefy').open()<cr>";
      options.desc = "Minty Color Picker";
    }
  ];
}
