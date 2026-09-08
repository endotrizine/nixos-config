return {
  'kyazdani42/nvim-tree.lua',
  -- Грузим сразу при старте, не лениво: дерево файлов нужно с первой секунды,
  -- откладывать его загрузку до первого :NvimTreeToggle не даёт ощутимой
  -- экономии, зато добавляет микро-задержку на первый вызов.
  lazy = false,
  config = function()
    require('nvim-tree').setup({
      hijack_cursor = false,
      on_attach = function(bufnr)
        local bufmap = function(lhs, rhs, desc)
          vim.keymap.set('n', lhs, rhs, { buffer = bufnr, desc = desc })
        end

        local api = require('nvim-tree.api')
        api.config.mappings.default_on_attach(bufnr)

        -- Эти маппинги живут только внутри буфера дерева файлов, не влияют
        -- на обычное редактирование текста в других буферах.
        bufmap('L', api.node.open.edit, 'Expand folder or go to file')
        bufmap('H', api.node.navigate.parent_close, 'Close parent folder')
        bufmap('gh', api.tree.toggle_hidden_filter, 'Toggle hidden files')
      end,
    })

    -- Автозакрытие, если nvim-tree остался последним открытым окном.
    -- E444 фикс: QuitPre срабатывает ДО фактического закрытия текущего окна,
    -- так что #wins в этот момент ещё включает окно, которое сейчас закрывается.
    -- Раньше условие "#wins - #tree_wins == 1" иногда ловило момент, когда
    -- единственное оставшееся окно — само дерево, и nvim_win_close на нём
    -- падает с "Нельзя закрыть последнее окно". Используем pcall, чтобы
    -- в любом пограничном случае просто тихо ничего не делать, а не падать.
    vim.api.nvim_create_autocmd('QuitPre', {
      callback = function()
        local wins = vim.api.nvim_list_wins()
        local tree_wins = {}
        local other_wins = {}
        for _, w in ipairs(wins) do
          if vim.bo[vim.api.nvim_win_get_buf(w)].filetype == 'NvimTree' then
            table.insert(tree_wins, w)
          else
            table.insert(other_wins, w)
          end
        end

        -- Закрываем дерево только если помимо него остаётся ровно одно
        -- обычное окно (то, которое сейчас и закрывают) — тогда после
        -- его закрытия дерево действительно останется в одиночестве.
        if #tree_wins > 0 and #other_wins == 1 then
          for _, w in ipairs(tree_wins) do
            pcall(vim.api.nvim_win_close, w, true)
          end
        end
      end,
    })
  end,
}
