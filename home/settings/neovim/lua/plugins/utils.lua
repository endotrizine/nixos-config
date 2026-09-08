return {
  -- :Bdelete — удаляет буфер, не закрывая сплит/окно (в отличие от :bd). Команда,
  -- не переопределение стандартной работы с буферами.
  { 'moll/vim-bbye', cmd = 'Bdelete' },

  {
    'akinsho/toggleterm.nvim',
    keys = { { '<C-g>', desc = 'Toggle terminal' } },
    opts = {
      open_mapping = [[<C-g>]],
      direction = 'horizontal',
      shade_terminals = true,
    },
  },
}
