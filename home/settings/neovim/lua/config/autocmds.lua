-- ========================================================================== --
-- ==                               AUTOCMDS                                == --
-- ========================================================================== --

local group = vim.api.nvim_create_augroup('user_cmds', { clear = true })

-- Подсветка при yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight on yank',
  group = group,
  callback = function()
    vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 })
  end,
})

-- q закрывает help/man — это штатное поведение многих таких буферов и в ванильном
-- vim, просто не всегда включено по умолчанию; не путать с кастомизацией motion.
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'help', 'man' },
  group = group,
  command = 'nnoremap <buffer> q <cmd>quit<cr>',
})

-- Абсолютные номера строк в command-mode (удобно для :123), относительные — в normal
local cmd_group = vim.api.nvim_create_augroup('CmdLineLineNumbers', { clear = true })

vim.api.nvim_create_autocmd('CmdlineEnter', {
  group = cmd_group,
  pattern = ':',
  callback = function()
    vim.opt.relativenumber = false
    vim.cmd('redraw')
  end,
})

vim.api.nvim_create_autocmd('CmdlineLeave', {
  group = cmd_group,
  pattern = ':',
  callback = function()
    vim.opt.relativenumber = true
  end,
})

-- Пресет для конспектирования (Markdown и LaTeX): spell-check, перенос строк, конceal
local notes_group = vim.api.nvim_create_augroup('NotesPreset', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = notes_group,
  pattern = { 'markdown', 'tex' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { 'ru', 'en' }
    vim.opt_local.conceallevel = 2
  end,
})
