return {
  { 'kyazdani42/nvim-web-devicons' },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'SmiteshP/nvim-navic' },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'catppuccin-mocha',
          icons_enabled = true,
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = { statusline = { 'NvimTree' } },
          globalstatus = true,
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = {
            { 'filename', file_status = true, path = 1 },
            {
              function() return require('nvim-navic').get_location() end,
              cond = function() return require('nvim-navic').is_available() end,
            },
          },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
      })
    end,
  },

  {
    'akinsho/bufferline.nvim',
    config = function()
      require('bufferline').setup({
        options = {
          mode = 'buffers',
          offsets = { { filetype = 'NvimTree' } },
        },
        highlights = {
          buffer_selected = { italic = false },
          indicator_selected = {
            fg = { attribute = 'fg', highlight = 'Function' },
            italic = false,
          },
        },
      })
    end,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    version = '3.x',
    main = 'ibl',
    opts = {
      enabled = true,
      scope = { enabled = false },
      indent = { char = '▏' },
    },
  },

  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    opts = {},
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
      { '<leader>xq', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix (Trouble)' },
    },
  },

  {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    opts = {}, -- прогресс LSP в углу экрана (видно, что rust-analyzer/roslyn ещё грузятся)
  },

  -- nvim-navic сам по себе не имеет setup — подключается через LspAttach, см. plugins/lsp.lua
  { 'SmiteshP/nvim-navic', lazy = true },
}
