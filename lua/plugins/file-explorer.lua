return {
  { -- Traditional file tree
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup {
        sort_by = 'modification_time',
        view = {
          width = 35,
          side = 'left',
          preserve_window_proportions = true,
        },
        actions = {
          open_file = {
            resize_window = true,
          },
        },
      }

      -- Keymaps for syncing current file with nvim-tree
      vim.keymap.set('n', '<leader>ef', function()
        -- Reveal file in tree but stay in current window
        require('nvim-tree.api').tree.find_file { open = true, focus = false }
      end, { desc = 'Reveal file in tree' })

      vim.keymap.set('n', '<leader>eF', function()
        -- Reveal file in tree and jump to it
        require('nvim-tree.api').tree.find_file { open = true, focus = true }
      end, { desc = 'Reveal file in tree and focus' })
    end,
  },

  { -- Buffer-based file editing
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = false, -- Keep nvim-tree as default
      view_options = {
        show_hidden = true,
      },
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = false,
  },

  { -- Web devicons (used by multiple plugins)
    'nvim-tree/nvim-web-devicons',
    opts = {},
  },
}
