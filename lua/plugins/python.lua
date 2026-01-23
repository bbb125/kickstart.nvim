return {
  { -- Virtual environment selector
    'linux-cultist/venv-selector.nvim',
    branch = 'regexp',
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-telescope/telescope.nvim',
      'mfussenegger/nvim-dap-python',
    },
    ft = 'python',
    keys = {
      { '<leader>pv', '<cmd>VenvSelect<cr>', desc = '[P]ython [V]env Select' },
      { '<leader>pc', '<cmd>VenvSelectCached<cr>', desc = '[P]ython [C]ached Venv' },
    },
    opts = {
      auto_refresh = true,
      search_venv_managers = true,
      search_workspace = true,
      search = true,
      name = { 'venv', '.venv', 'env', '.env' },
      fd_binary_name = 'fd',
    },
  },

  { -- Python test runner
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-python',
    },
    ft = 'python',
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-python' {
            dap = { justMyCode = false },
            args = { '--log-level', 'DEBUG' },
            runner = 'pytest',
            python = function()
              -- Try to get the venv python
              local venv = os.getenv 'VIRTUAL_ENV'
              if venv then
                return venv .. '/bin/python'
              end
              return 'python3'
            end,
          },
        },
      }

      -- Test keymaps
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'python',
        callback = function()
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = true, desc = 'Test: ' .. desc })
          end

          map('<leader>tt', function()
            require('neotest').run.run()
          end, '[T]est Nearest')

          map('<leader>tf', function()
            require('neotest').run.run(vim.fn.expand '%')
          end, '[T]est [F]ile')

          map('<leader>ts', function()
            require('neotest').summary.toggle()
          end, '[T]est [S]ummary')

          map('<leader>to', function()
            require('neotest').output.open { enter = true }
          end, '[T]est [O]utput')

          map('<leader>tO', function()
            require('neotest').output_panel.toggle()
          end, '[T]est [O]utput Panel')

          map('<leader>td', function()
            require('neotest').run.run { strategy = 'dap' }
          end, '[T]est [D]ebug Nearest')

          map('<leader>tS', function()
            require('neotest').run.stop()
          end, '[T]est [S]top')

          map('[t', function()
            require('neotest').jump.prev { status = 'failed' }
          end, 'Previous Failed Test')

          map(']t', function()
            require('neotest').jump.next { status = 'failed' }
          end, 'Next Failed Test')
        end,
      })
    end,
  },

  { -- Python debugging support
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    dependencies = {
      'mfussenegger/nvim-dap',
      'rcarriga/nvim-dap-ui',
    },
    config = function()
      local path = require('mason-registry').get_package('debugpy'):get_install_path()
      require('dap-python').setup(path .. '/venv/bin/python')

      -- Python debug keymaps
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'python',
        callback = function()
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = true, desc = 'Debug: ' .. desc })
          end

          map('<leader>dpm', function()
            require('dap-python').test_method()
          end, '[D]ebug [P]ython [M]ethod')

          map('<leader>dpc', function()
            require('dap-python').test_class()
          end, '[D]ebug [P]ython [C]lass')

          map('<leader>dps', function()
            require('dap-python').debug_selection()
          end, '[D]ebug [P]ython [S]election')
        end,
      })
    end,
  },
}
