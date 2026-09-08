return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '➤' },
        topdelete = { text = '➤' },
        changedelete = { text = '▎' },
      },
    },
  },

  -- Грузим сразу: команды :Git/:G используются с первых секунд работы в репе.
  { 'tpope/vim-fugitive', lazy = false },

  -- Красивый постраничный diff-просмотрщик: дерево изменённых файлов слева +
  -- side-by-side diff с подсветкой по словам справа. Полезен и сам по себе
  -- (:DiffviewOpen, :DiffviewFileHistory %), и как diff-движок для neogit ниже.
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory', 'DiffviewClose' },
  },

  -- Интерактивный git-интерфейс в духе Magit (Emacs): статус репо одним
  -- экраном (untracked/unstaged/staged/stashes/unpulled/unmerged секции),
  -- стейджинг файлов/hunks курсором вместо `git add -p`, коммиты, rebase,
  -- branches — всё из одного интерактивного меню. Дополняет, а не заменяет
  -- fugitive: fugitive удобнее для точечных вещей (:Gblame на строке),
  -- neogit — когда разбираешь большой diff перед коммитом.
  {
    'NeogitOrg/neogit',
    cmd = 'Neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim', -- уже есть в проекте, даёт multi-select в меню neogit
    },
    opts = {
      integrations = {
        diffview = true,
        telescope = true,
      },
    },
  },
}
