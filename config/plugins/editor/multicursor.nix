{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [
    vim-visual-multi
  ];
}
