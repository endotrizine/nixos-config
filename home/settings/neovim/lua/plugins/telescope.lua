return {
  'nvim-telescope/telescope.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    -- 1. Переключение по числу: нажимаете <leader>b и затем номер буфера (например, <leader>b3)
    vim.keymap.set('n', '<leader>b', ':<C-u>b ', { desc = 'Go to buffer by number (type number next)' })

    -- 2. Хоткеи "влево/вправо" для циклического перелистывания буферов
    -- (Используем Shift + h/l, это самый популярный стандарт в Neovim для вкладок/буферов)
    vim.keymap.set('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev buffer' })
    vim.keymap.set('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next buffer' })

    -- Дефолтные бинды Telescope
    vim.keymap.set('n', '<leader>?', '<cmd>Telescope oldfiles<cr>', { desc = 'Recently opened files' })
    vim.keymap.set('n', '<leader><space>', '<cmd>Telescope buffers<cr>', { desc = 'Open buffers' })
    vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Find files' })
    vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'Live grep' })
    vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>', { desc = 'Diagnostics list' })
    vim.keymap.set('n', '<leader>fs', '<cmd>Telescope current_buffer_fuzzy_find<cr>', { desc = 'Fuzzy find in buffer' })
  end,
}
