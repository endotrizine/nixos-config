-- ========================================================================== --
-- ==                            EDITOR SETTINGS                           == --
-- ========================================================================== --

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.mouse = 'a'
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.wrap = true
opt.breakindent = true
opt.tabstop = 4
opt.shiftwidth = 4
vim.opt.softtabstop = 4
opt.expandtab = true
opt.signcolumn = 'yes'
opt.clipboard = 'unnamedplus'
opt.updatetime = 250 -- быстрее диагностика/CursorHold, важно для LSP-фич
opt.virtualedit = 'onemore'
opt.showmode = false -- статус-бар (lualine) и так показывает режим

-- Space как leader — используется только для команд/плагинов (which-key, telescope, LSP-action),
-- НЕ для базовых операций редактирования текста.
vim.g.mapleader = ' '

