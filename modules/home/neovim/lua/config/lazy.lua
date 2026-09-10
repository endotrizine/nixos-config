-- ========================================================================== --
-- ==                          LAZY.NVIM BOOTSTRAP                         == --
-- ========================================================================== --

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  print('Installing lazy.nvim....')
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- Каждый файл в lua/plugins/*.lua должен возвращать таблицу спеков (или один спек).
-- lazy.nvim сам подхватывает все файлы в этой директории через import.
require('lazy').setup({
  spec = {
    { import = 'plugins' },
  },
  install = { colorscheme = { 'catppuccin' } },
  checker = { enabled = false }, -- не проверяем обновления плагинов автоматически при старте
})
