{ pkgs, ... }:
{
  programs.lazyvim = {
    enable = true;

    # Конфигурация встроенных опций Neovim (включая локализацию и орфографию)
    config.options = ''
      vim.opt.spell = true
      vim.opt.spelllang = { "en", "ru" }
    '';

    # Настройка плагинов
    plugins = {
      catppuccin = ''
        return {
          { "LazyVim/LazyVim", opts = { colorscheme = "catppuccin" } },
          {
            "catppuccin",
            opts = {
              flavour = "mocha",
              transparent_background = true,
            },
          },
        }
      '';

      # Скролл автокомплита через Tab / Shift+Tab
      blink = ''
        return {
          {
            "saghen/blink.cmp",
            opts = {
              keymap = { preset = "super-tab" },
            },
          },
        }
      '';

      # Добавляем автоматическое определение табов/пробелов (sleuth)
      sleuth = ''
        return {
          { "tpope/vim-sleuth" }
        }
      '';
    };

    # Парсеры Treesitter
    treesitterParsers = with pkgs.vimPlugins.nvim-treesitter-parsers; [
      cpp
      c_sharp
      fsharp
      git_config
      gitcommit
      git_rebase
      gitignore
      gitattributes
      go
      gomod
      gowork
      gosum
      nix
      ninja
      rst
      rust
      ron
      sql
    ];

    # Дополнительные системные пакеты
    extraPackages = with pkgs; [
      statix
      # vim-sleuth из репозитория Nixpkgs, чтобы LazyVim увидел сам плагин
      vimPlugins.vim-sleuth
    ];
  };
}
