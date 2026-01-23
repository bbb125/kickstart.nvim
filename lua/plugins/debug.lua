return {
  { -- Debug Adapter Protocol client
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'theHamsta/nvim-dap-virtual-text',
      'jay-babu/mason-nvim-dap.nvim',
    },
    keys = {
      { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Toggle [B]reakpoint' },
      { '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, desc = 'Debug: Set Conditional [B]reakpoint' },
      { '<leader>dc', function() require('dap').continue() end, desc = 'Debug: [C]ontinue' },
      { '<leader>di', function() require('dap').step_into() end, desc = 'Debug: Step [I]nto' },
      { '<leader>do', function() require('dap').step_over() end, desc = 'Debug: Step [O]ver' },
      { '<leader>dO', function() require('dap').step_out() end, desc = 'Debug: Step [O]ut' },
      { '<leader>dr', function() require('dap').repl.toggle() end, desc = 'Debug: Toggle [R]EPL' },
      { '<leader>dl', function() require('dap').run_last() end, desc = 'Debug: Run [L]ast' },
      { '<leader>dt', function() require('dap').terminate() end, desc = 'Debug: [T]erminate' },
      { '<leader>du', function() require('dapui').toggle() end, desc = 'Debug: Toggle [U]I' },
      { '<leader>de', function() require('dapui').eval() end, desc = 'Debug: [E]valuate', mode = { 'n', 'v' } },
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      require('mason-nvim-dap').setup {
        automatic_installation = true,
        handlers = {},
        ensure_installed = {
          'python',
        },
      }

      -- DAP UI setup
      dapui.setup {
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        controls = {
          icons = {
            pause = '⏸',
            play = '▶',
            step_into = '⏎',
            step_over = '⏭',
            step_out = '⏮',
            step_back = 'b',
            run_last = '▶▶',
            terminate = '⏹',
            disconnect = '⏏',
          },
        },
      }

      -- Virtual text for debugging
      require('nvim-dap-virtual-text').setup {
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
      }

      -- Automatically open/close DAP UI
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      -- Breakpoint signs
      vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '◆', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
      vim.fn.sign_define('DapLogPoint', { text = '◆', texthl = 'DapLogPoint', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '→', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })
      vim.fn.sign_define('DapBreakpointRejected', { text = '○', texthl = 'DapBreakpointRejected', linehl = '', numhl = '' })
    end,
  },
}
