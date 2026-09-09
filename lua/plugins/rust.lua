return {
  { -- Modern Rust plugin (replaces rust-tools.nvim)
    'mrcjkb/rustaceanvim',
    version = '^5',
    lazy = false, -- Load at startup for Rust files
    dependencies = { 'nvim-lua/plenary.nvim' },
    init = function()
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {
          hover_actions = {
            auto_focus = true,
          },
        },
        -- LSP configuration
        server = {
          on_attach = function(client, bufnr)
            -- Custom keymaps for Rust
            local map = function(keys, func, desc)
              vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'Rust: ' .. desc })
            end

            -- Rust-specific actions
            map('<leader>ca', function()
              vim.cmd.RustLsp 'codeAction'
            end, '[C]ode [A]ction')

            map('<leader>rr', function()
              vim.cmd.RustLsp 'runnables'
            end, '[R]un [R]unnables')

            map('<leader>rd', function()
              vim.cmd.RustLsp 'debuggables'
            end, '[R]un [D]ebuggables')

            map('<leader>rt', function()
              vim.cmd.RustLsp 'testables'
            end, '[R]un [T]estables')

            map('<leader>re', function()
              vim.cmd.RustLsp 'expandMacro'
            end, '[R]ust [E]xpand Macro')

            map('<leader>rc', function()
              vim.cmd.RustLsp 'openCargo'
            end, '[R]ust Open [C]argo.toml')

            map('<leader>rp', function()
              vim.cmd.RustLsp 'parentModule'
            end, '[R]ust [P]arent Module')

            map('<leader>rj', function()
              vim.cmd.RustLsp 'joinLines'
            end, '[R]ust [J]oin Lines')

            map('<leader>rh', function()
              vim.cmd.RustLsp { 'hover', 'actions' }
            end, '[R]ust [H]over Actions')

            map('<leader>rm', function()
              vim.cmd.RustLsp 'rebuildProcMacros'
            end, '[R]ust Rebuild [M]acros')

            map('K', function()
              vim.cmd.RustLsp { 'hover', 'actions' }
            end, 'Hover Actions')
          end,
          default_settings = {
            -- rust-analyzer language server configuration
            ['rust-analyzer'] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = {
                  enable = true,
                },
              },
              -- Add clippy lints for Rust
              checkOnSave = {
                allFeatures = true,
                command = 'clippy',
                extraArgs = { '--no-deps' },
              },
              procMacro = {
                enable = true,
                ignored = {
                  ['async-trait'] = { 'async_trait' },
                  ['napi-derive'] = { 'napi' },
                  ['async-recursion'] = { 'async_recursion' },
                },
              },
            },
          },
        },
        -- Use rustaceanvim's debugger discovery (lldb-dap / codelldb).
        dap = {},
      }
    end,
  },

  { -- Cargo.toml management
    'saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('crates').setup {
        completion = {
          cmp = {
            enabled = true,
          },
        },
        lsp = {
          enabled = true,
          actions = true,
          completion = true,
          hover = true,
        },
      }

      -- Crates keymaps (only in Cargo.toml)
      vim.api.nvim_create_autocmd('BufRead', {
        pattern = 'Cargo.toml',
        callback = function()
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = true, desc = 'Crates: ' .. desc })
          end

          map('<leader>ct', require('crates').toggle, '[C]rates [T]oggle')
          map('<leader>cr', require('crates').reload, '[C]rates [R]eload')

          map('<leader>cv', require('crates').show_versions_popup, '[C]rates [V]ersions')
          map('<leader>cf', require('crates').show_features_popup, '[C]rates [F]eatures')
          map('<leader>cd', require('crates').show_dependencies_popup, '[C]rates [D]ependencies')

          map('<leader>cu', require('crates').update_crate, '[C]rates [U]pdate')
          map('<leader>ca', require('crates').update_all_crates, '[C]rates Update [A]ll')
          map('<leader>cU', require('crates').upgrade_crate, '[C]rates [U]pgrade')
          map('<leader>cA', require('crates').upgrade_all_crates, '[C]rates Upgrade [A]ll')

          map('<leader>cH', require('crates').open_homepage, '[C]rates [H]omepage')
          map('<leader>cR', require('crates').open_repository, '[C]rates [R]epository')
          map('<leader>cD', require('crates').open_documentation, '[C]rates [D]ocs')
          map('<leader>cC', require('crates').open_crates_io, '[C]rates [C]rates.io')
        end,
      })

      -- Add crates.nvim to cmp sources
      vim.api.nvim_create_autocmd('BufRead', {
        pattern = 'Cargo.toml',
        callback = function()
          local cmp = require 'cmp'
          cmp.setup.buffer {
            sources = cmp.config.sources({ { name = 'crates' } }, cmp.get_config().sources),
          }
        end,
      })
    end,
  },
}
