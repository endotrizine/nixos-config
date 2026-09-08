return {
  'famiu/bufdelete.nvim',
  -- Загружаем по требованию, когда нажимаем горячую клавишу
  keys = {
    { '<leader>bd', '<cmd>Bdelete<cr>', desc = 'Close buffer smartly' },
    { '<leader>bD', '<cmd>Bdelete!<cr>', desc = 'Force close buffer smartly (ignore changes)' },
  },
}
