return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000, -- грузится первым, чтобы остальные плагины могли подхватить цвета
  config = function()
    require('catppuccin').setup({
      flavour = 'mocha',
      transparent_background = true,
    })
    vim.cmd.colorscheme('catppuccin')
  end,
}
