return {
  {
    'hrsh7th/cmp-nvim-lsp',
    lazy = false,
  },

  {
    'SmiteshP/nvim-navic',
    lazy = false,
  },

  {
    'neovim/nvim-lspconfig',
    lazy = false,

    config = function()
      local capabilities = require('config.lsp_capabilities').get()

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),

        callback = function(ev)
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, {
              buffer = ev.buf,
              silent = true,
              desc = desc,
            })
          end

          map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
          map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
          map('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation')
          map('n', 'gr', vim.lsp.buf.references, 'Go to references')
          map('n', 'K', vim.lsp.buf.hover, 'Hover documentation')

          map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
          map('n', '<leader>ca', vim.lsp.buf.code_action, 'Code action')
          map('n', '<leader>ds', vim.lsp.buf.document_symbol, 'Document symbols')

          map('i', '<C-k>', vim.lsp.buf.signature_help, 'Signature help')

          local client = vim.lsp.get_client_by_id(ev.data.client_id)

          if client
            and client.server_capabilities.documentSymbolProvider
          then
            require('nvim-navic').attach(client, ev.buf)
          end
        end,
      })

      vim.keymap.set(
        'n',
        '<leader>e',
        vim.diagnostic.open_float,
        { desc = 'Show line diagnostics' }
      )

      vim.keymap.set(
        'n',
        ']d',
        vim.diagnostic.goto_next,
        { desc = 'Next diagnostic' }
      )

      vim.keymap.set(
        'n',
        '[d',
        vim.diagnostic.goto_prev,
        { desc = 'Previous diagnostic' }
      )

      local servers = {
        nixd = {
          settings = {
            nixd = {
              formatting = {
                command = { 'nixpkgs-fmt' },
              },
            },
          },
        },

        gopls = {
          settings = {
            gopls = {
              staticcheck = true,

              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
            },
          },
        },

        pyright = {},
        ruff = {},
        clangd = {},
        marksman = {},
        texlab = {},
      }

      for server, config in pairs(servers) do
        config.capabilities = capabilities

        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end
    end,
  },

  {
    'seblyng/roslyn.nvim',
    lazy = false,

    opts = {
      filewatching = 'off',
    },

    config = function(_, opts)
      local capabilities = require('config.lsp_capabilities').get()

      vim.lsp.config('roslyn', {
        capabilities = capabilities,

        settings = {
          ['csharp|inlay_hints'] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,

            dotnet_enable_inlay_hints_for_indexer_parameters = true,
            dotnet_enable_inlay_hints_for_literal_parameters = true,
            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
            dotnet_enable_inlay_hints_for_other_parameters = true,
            dotnet_enable_inlay_hints_for_parameters = true,
          },

          ['csharp|code_lens'] = {
            dotnet_enable_references_code_lens = true,
          },

          ['csharp|background_analysis'] = {
            dotnet_analyzer_diagnostics_scope = 'fullSolution',
            dotnet_compiler_diagnostics_scope = 'fullSolution',
          },
        },
      })

      require('roslyn').setup(opts)
    end,
  },

  {
    'mrcjkb/rustaceanvim',
    version = '^5',
    lazy = false,

    init = function()
      vim.g.rustaceanvim = {
        server = {
          capabilities = require('config.lsp_capabilities').get(),

          default_settings = {
            ['rust-analyzer'] = {
              cargo = {
                allFeatures = true,
              },

              checkOnSave = true,

              check = {
                command = 'clippy',
              },

              inlayHints = {
                bindingModeHints = {
                  enable = true,
                },

                closureReturnTypeHints = {
                  enable = true,
                },
              },
            },
          },
        },
      }
    end,
  },
}
