return {
  'windwp/nvim-autopairs',
  -- Плагин активируется в тот момент, когда вы переходите в режим вставки (пишете код)
  event = "InsertEnter",
  opts = {
    check_ts = true, -- Интеграция с Tree-sitter, чтобы скобки не ставились внутри комментариев или строк
    ts_config = {
      lua = { 'string' }, -- Не добавлять пары внутри lua строк
      javascript = { 'template_string' }, -- Не добавлять пары внутри js template literals
    }
  }
}
