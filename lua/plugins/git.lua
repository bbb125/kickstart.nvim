return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  { -- Side-by-side diff view for commits, file history, and merge conflicts
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Diff view (working changes)' },
      { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'File history (current file)' },
      { '<leader>gH', '<cmd>DiffviewFileHistory<cr>', desc = 'File history (all)' },
      { '<leader>gq', '<cmd>DiffviewClose<cr>', desc = 'Close diff view' },
      {
        '<leader>gc',
        function()
          require('telescope.builtin').git_commits {
            attach_mappings = function(_, map)
              local actions = require 'telescope.actions'
              map('i', '<CR>', function(prompt_bufnr)
                local selection = require('telescope.actions.state').get_selected_entry()
                actions.close(prompt_bufnr)
                vim.cmd('DiffviewOpen ' .. selection.value .. '^!')
              end)
              map('n', '<CR>', function(prompt_bufnr)
                local selection = require('telescope.actions.state').get_selected_entry()
                actions.close(prompt_bufnr)
                vim.cmd('DiffviewOpen ' .. selection.value .. '^!')
              end)
              return true
            end,
          }
        end,
        desc = 'Pick commit to diff',
      },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        default = {
          layout = 'diff2_horizontal',
        },
        merge_tool = {
          layout = 'diff3_mixed',
        },
      },
    },
  },
}
