-- ========================================================================== --
-- ==                    SHARED LSP CAPABILITIES                           == --
-- ========================================================================== --
-- roslyn.nvim, rustaceanvim и общий lspconfig-блок все хотят одинаковые
-- capabilities (расширенные под nvim-cmp). Раньше это лежало в глобальной
-- переменной _G, выставляемой из config() блока lspconfig — что ломалось,
-- если roslyn/rustaceanvim грузились ДО lspconfig (lazy.nvim порядок загрузки
-- не гарантирован без явных зависимостей). Мемоизация здесь работает при любом
-- порядке загрузки, т.к. require('cmp_nvim_lsp') просто требует, чтобы плагин
-- cmp-nvim-lsp был установлен — не важно, инициализирован ли он ещё.

local M = {}

local cached = nil

function M.get()
  if not cached then
    cached = require('cmp_nvim_lsp').default_capabilities()
  end
  return cached
end

return M
