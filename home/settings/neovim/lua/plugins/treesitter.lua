-- ========================================================================== --
-- ==                    TREESITTER (new `main`-branch API)                == --
-- ========================================================================== --
-- В апреле 2026 nvim-treesitter получил полный рефакторинг: старая ветка
-- `master` заморожена и архивирована, новая `main` — теперь дефолт.
-- Старый API (`require('nvim-treesitter.configs').setup{...}` с полями
-- highlight/indent/ensure_installed) БОЛЬШЕ НЕ РАБОТАЕТ. Новый плагин
-- занимается только установкой парсеров; highlighting/indent включаются
-- через встроенный в сам Neovim `vim.treesitter.start()`.
--
-- Требование: в системе должен быть установлен `tree-sitter` CLI —
-- новый плагин компилирует парсеры локально, а не тянет их предсобранными.
-- (добавь `tree-sitter` в packages.nix, если ещё не установлен)

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    lazy = false, -- highlighting нужен сразу, откладывать нет смысла
    init = function()
      local ensure_installed = {
        'javascript', 'typescript', 'tsx', 'lua', 'vim', 'vimdoc', 'css', 'json',
        'rust', 'c_sharp', 'markdown', 'markdown_inline', 'latex',
        'python', 'go', 'gomod', 'gowork', 'gosum',
        'c', 'cpp', 'cmake',
        'nix',
      }

      -- Ставим только то, чего ещё нет — иначе на каждом старте плагин
      -- пытался бы переустанавливать уже установленные парсеры.
      local ok, ts = pcall(require, 'nvim-treesitter')
      if ok then
        local already_installed = ts.get_installed and ts.get_installed() or {}
        local to_install = vim.iter(ensure_installed)
          :filter(function(parser) return not vim.tbl_contains(already_installed, parser) end)
          :totable()

        if #to_install > 0 then
          ts.install(to_install)
        end
      end

      -- Включаем ТОЛЬКО подцветку (highlighting) от Tree-sitter.
      -- Ошибочный экспериментальный индент убран, чтобы избежать конфликтов с LSP.
      vim.api.nvim_create_autocmd('FileType', {
        -- Игнорируем nvim-tree, панели плагинов, терминалы и системные окна
        pattern = '*',
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          local buftype = vim.bo[args.buf].buftype

          -- Если это nvim-tree или другой служебный буфер, ничего не делаем
          if ft == 'NvimTree' or buftype == 'nofile' or buftype == 'terminal' then
            return
          end

          -- pcall: если парсера для этого filetype ещё нет, просто не падаем с ошибкой
          pcall(vim.treesitter.start)

          -- Включаем умные встроенные отступы Neovim в качестве базы для LSP
          vim.bo[args.buf].smartindent = true
        end,
      })
    end,
  },

  -- textobjects — отдельный плагин, тоже переехал на main branch с новым API:
  -- вместо вложенной таблицы keymaps теперь прямые vim.keymap.set с вызовом
  -- require('nvim-treesitter-textobjects.select').select_textobject(...)
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-treesitter-textobjects').setup({
        select = {
          lookahead = true,
        },
      })

      -- af/if/ac/ic — расширение стандартных text objects vim (a/i + объект),
      -- не переопределение чего-либо ванильного, просто добавляет
      -- function/class objects, которых в vanilla vim не существует.
      local select_textobject = function(query, query_group)
        return function()
          require('nvim-treesitter-textobjects.select').select_textobject(query, query_group or 'textobjects')
        end
      end

      vim.keymap.set({ 'x', 'o' }, 'af', select_textobject('@function.outer'), { desc = 'Select outer function' })
      vim.keymap.set({ 'x', 'o' }, 'if', select_textobject('@function.inner'), { desc = 'Select inner function' })
      vim.keymap.set({ 'x', 'o' }, 'ac', select_textobject('@class.outer'), { desc = 'Select outer class' })
      vim.keymap.set({ 'x', 'o' }, 'ic', select_textobject('@class.inner'), { desc = 'Select inner class' })
    end,
  },

  -- gcc / gc в visual — стандартный де-факто бинд комментирования в экосистеме vim-plugins
  { 'numToStr/Comment.nvim', event = { 'BufReadPost', 'BufNewFile' }, opts = {} },

  -- Расширяет cs"' / ds" / ys{motion}{char} — привычный vim-surround стандарт
  { 'tpope/vim-surround', event = { 'BufReadPost', 'BufNewFile' } },

  -- Расширяет text objects (in/al для скобок, кавычек, аргументов)
  { 'wellle/targets.vim', event = { 'BufReadPost', 'BufNewFile' } },

  -- Позволяет . повторять команды из других плагинов (surround и т.д.)
  { 'tpope/vim-repeat', event = { 'BufReadPost', 'BufNewFile' } },
}

