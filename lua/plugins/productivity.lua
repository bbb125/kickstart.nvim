-- Productivity plugins: search/replace, undo, file marks, UI, notes, refactoring
return {
  -- grug-far: Fast search and replace across files
  {
    'MagicDuck/grug-far.nvim',
    cmd = 'GrugFar',
    keys = {
      {
        '<leader>sr',
        function()
          require('grug-far').open()
        end,
        desc = '[S]earch and [R]eplace (grug-far)',
      },
      {
        '<leader>sr',
        function()
          require('grug-far').open { prefills = { search = vim.fn.expand '<cword>' } }
        end,
        mode = 'v',
        desc = '[S]earch and [R]eplace selection',
      },
    },
    opts = {
      headerMaxWidth = 80,
    },
  },

  -- undotree: Visualize undo history
  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    keys = {
      { '<leader>U', '<cmd>UndotreeToggle<cr>', desc = '[U]ndo tree' },
    },
  },

  -- harpoon: Quick file navigation (mark files, jump instantly)
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      {
        '<leader>ha',
        function()
          require('harpoon'):list():add()
        end,
        desc = '[H]arpoon [A]dd file',
      },
      {
        '<leader>hh',
        function()
          local harpoon = require 'harpoon'
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = '[H]arpoon menu',
      },
      {
        '<leader>1',
        function()
          require('harpoon'):list():select(1)
        end,
        desc = 'Harpoon file 1',
      },
      {
        '<leader>2',
        function()
          require('harpoon'):list():select(2)
        end,
        desc = 'Harpoon file 2',
      },
      {
        '<leader>3',
        function()
          require('harpoon'):list():select(3)
        end,
        desc = 'Harpoon file 3',
      },
      {
        '<leader>4',
        function()
          require('harpoon'):list():select(4)
        end,
        desc = 'Harpoon file 4',
      },
      {
        '<leader>hp',
        function()
          require('harpoon'):list():prev()
        end,
        desc = '[H]arpoon [P]revious',
      },
      {
        '<leader>hn',
        function()
          require('harpoon'):list():next()
        end,
        desc = '[H]arpoon [N]ext',
      },
    },
    config = function()
      require('harpoon'):setup {}
    end,
  },

  -- noice: Modern UI for messages, cmdline, popupmenu
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify', -- optional but nice notifications
    },
    opts = {
      lsp = {
        -- override markdown rendering for LSP hover/signature
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      presets = {
        bottom_search = true, -- use classic bottom cmdline for search
        command_palette = true, -- position cmdline and popupmenu together
        long_message_to_split = true, -- long messages go to split
        inc_rename = false, -- no input dialog for inc-rename
        lsp_doc_border = true, -- add border to hover docs
      },
      routes = {
        -- Hide "written" messages
        {
          filter = {
            event = 'msg_show',
            kind = '',
            find = 'written',
          },
          opts = { skip = true },
        },
      },
    },
    keys = {
      {
        '<leader>nd',
        function()
          require('noice').cmd 'dismiss'
        end,
        desc = '[N]oice [D]ismiss',
      },
      {
        '<leader>nl',
        function()
          require('noice').cmd 'last'
        end,
        desc = '[N]oice [L]ast message',
      },
      {
        '<leader>nh',
        function()
          require('noice').cmd 'history'
        end,
        desc = '[N]oice [H]istory',
      },
    },
  },

  -- neorg: Org-mode for Neovim (notes, todos, documents)
  {
    'nvim-neorg/neorg',
    lazy = false, -- needs to load early for treesitter
    version = '*', -- use latest stable
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('neorg').setup {
        load = {
          ['core.defaults'] = {}, -- default modules
          ['core.concealer'] = {}, -- icons and concealing
          ['core.dirman'] = { -- workspace management
            config = {
              workspaces = {
                notes = '~/notes',
                work = '~/notes/work',
              },
              default_workspace = 'notes',
            },
          },
          ['core.completion'] = {
            config = {
              engine = 'nvim-cmp',
            },
          },
          ['core.keybinds'] = {
            config = {
              hook = function(keybinds)
                keybinds.remap_event('norg', 'n', '<leader>nc', 'core.looking-glass.magnify-code-block')
              end,
            },
          },
        },
      }
    end,
    keys = {
      { '<leader>ni', '<cmd>Neorg index<cr>', desc = '[N]eorg [I]ndex' },
      { '<leader>nr', '<cmd>Neorg return<cr>', desc = '[N]eorg [R]eturn' },
      { '<leader>nw', '<cmd>Neorg workspace<cr>', desc = '[N]eorg [W]orkspace' },
      { '<leader>nj', '<cmd>Neorg journal today<cr>', desc = '[N]eorg [J]ournal today' },
    },
    ft = 'norg',
  },

  -- refactoring: Extract function/variable, inline, etc.
  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    keys = {
      {
        '<leader>re',
        function()
          require('refactoring').refactor 'Extract Function'
        end,
        mode = 'x',
        desc = '[R]efactor [E]xtract function',
      },
      {
        '<leader>rf',
        function()
          require('refactoring').refactor 'Extract Function To File'
        end,
        mode = 'x',
        desc = '[R]efactor Extract [F]unction to file',
      },
      {
        '<leader>rv',
        function()
          require('refactoring').refactor 'Extract Variable'
        end,
        mode = 'x',
        desc = '[R]efactor Extract [V]ariable',
      },
      {
        '<leader>rI',
        function()
          require('refactoring').refactor 'Inline Function'
        end,
        mode = 'n',
        desc = '[R]efactor [I]nline function',
      },
      {
        '<leader>ri',
        function()
          require('refactoring').refactor 'Inline Variable'
        end,
        mode = { 'n', 'x' },
        desc = '[R]efactor [I]nline variable',
      },
      {
        '<leader>rb',
        function()
          require('refactoring').refactor 'Extract Block'
        end,
        mode = 'n',
        desc = '[R]efactor Extract [B]lock',
      },
      {
        '<leader>rr',
        function()
          require('refactoring').select_refactor()
        end,
        mode = { 'n', 'x' },
        desc = '[R]efactor select menu',
      },
    },
    opts = {},
  },
}
