# modules/home/neovim/default.nix
{ ... }:
{
  flake.modules.homeManager.common =
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

          # Настройка hardtime.nvim для искоренения спама клавишами h/j/k/l
          hardtime = ''
            return {
              {
                "m4xshen/hardtime.nvim",
                dependencies = { "MunifTanjim/nui.nvim" },
                opts = {},
              },
            }
          '';

          # Настройка LSP для Ассемблера (x86 / x86_64 / TASM / NASM)
          asm = ''
            return {
              {
                "neovim/nvim-lspconfig",
                opts = {
                  servers = {
                    asm_lsp = {
                      filetypes = { "asm", "vmasm", "s", "S" },
                    },
                  },
                },
              },
            }
          '';

          rustaceanvim = ''
            return {
              {
                "mrcjkb/rustaceanvim",
                version = "^5", -- или используйте вашу версию
                lazy = false,
                opts = {
                  server = {
                    default_settings = {
                      ["rust-analyzer"] = {
                        -- По умолчанию диагностика (cargo check) тяжелая и идет при сохранении.
                        -- Если вы хотите проверку на лету, у rust-analyzer есть встроенный механизм:
                        diagnostics = {
                          enable = true,
                          experimental = {
                            enable = true, -- Включает быструю встроенную проверку при вводе текста
                          },
                        },
                        -- Если вы вообще хотите отключить cargo check при сохранении:
                        -- checkOnSave = false, 
                      },
                    },
                  },
                },
              },
            }
          '';

          # Настройка Noice под маленькие экраны терминалов
          noice = ''
            return {
              {
                "folke/noice.nvim",
                opts = {
                  -- Настройка отображения окон (views) в Noice
                  views = {
                    -- 1. Сжимаем командную строку (: и /)
                    cmdline_popup = {
                      position = { row = 5, col = "50%" },
                      size = {
                        width = "40%", -- Ограничиваем ширину командной строки до 40%
                        height = "auto",
                      },
                    },
                    -- 2. Сжимаем всплывающие окна подсказок LSP и сдвигаем ИХ ВНИЗ
                    hover = {
                      -- anchor = "NW" означает "привязать левый верхний угол окна"
                      -- row = 2 сдвигает окно на 2 строки вниз от курсора, освобождая вашу строку
                      position = { row = 2, col = 0, anchor = "NW" },
                      size = {
                        max_width = 45,  -- Текст будет аккуратно переноситься на ширине 45 символов
                        max_height = 10, -- Окно не вырастет больше 10 строк в высоту
                      },
                      border = {
                        style = "rounded",
                      },
                    },
                  },
                },
              },
            }
          '';
        };

        # Парсеры Treesitter
        treesitterParsers = with pkgs.vimPlugins.nvim-treesitter-parsers; [
          asm # <--- Подсветка синтаксиса Ассемблера
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
          html
          zig
        ];

        # Дополнительные системные пакеты
        extraPackages = with pkgs; [
          statix
          asm-lsp # <--- Языковой сервер для Ассемблера (всплывающие подсказки по инструкциям)
          # vim-sleuth из репозитория Nixpkgs, чтобы LazyVim увидел сам плагин
          vimPlugins.vim-sleuth
          # Подтягиваем hardtime и его зависимость nui.nvim из Nixpkgs
          vimPlugins.hardtime-nvim
          vimPlugins.nui-nvim
        ];
      };
    };
}
