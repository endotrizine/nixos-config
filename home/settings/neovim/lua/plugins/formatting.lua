return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format({ async = true, lsp_fallback = true })
      end,
      mode = { 'n', 'v' },
      desc = 'Format buffer',
    },
  },
  opts = {
    formatters_by_ft = {
      cs = { 'csharpier' },
      python = { 'ruff_format' },
      rust = { 'rustfmt' },
      go = { 'goimports', 'gofumpt' },
      c = { 'clang_format' },
      cpp = { 'clang_format' },
      nix = { 'nixpkgs_fmt' },
      lua = { 'stylua' },
    },
    format_on_save = {
      timeout_ms = 2000,
      lsp_fallback = true,
    },
  },
}
