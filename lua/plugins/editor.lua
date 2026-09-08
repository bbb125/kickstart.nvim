return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').setup({
        ensure_installed = {
          'bash',
          'c',
          'cpp',
          'diff',
          'html',
          'javascript',
          'lua',
          'luadoc',
          'markdown',
          'markdown_inline',
          'python',
          'query',
          'rust',
          'vim',
          'vimdoc',
        },
        auto_install = true,
      })

      -- Treat files with filetype "c" as C++ for Tree-sitter
      vim.treesitter.language.register('cpp', 'c')
    end,
  },
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      require('mini.surround').setup()

      -- Simple and easy statusline.
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- Skip repeated whole-buffer search counts on large files.
      -- Search navigation and highlights stay enabled.
      local original_searchcount = statusline.section_searchcount
      statusline.section_searchcount = function(args)
        local lines = vim.api.nvim_buf_line_count(0)
        if vim.b.bigfile_detected == 1 or vim.api.nvim_buf_get_offset(0, lines) >= 2 * 1024 * 1024 then
          return ''
        end
        return original_searchcount(args)
      end

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },

  { -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  { -- Better marks
    'chentoast/marks.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  { -- Indent guides with scope highlighting
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = 'VeryLazy',
    opts = {
      indent = {
        char = '│',
      },
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
      },
    },
  },

  { -- Performance for large files
    'LunarVim/bigfile.nvim',
    config = function()
      require('bigfile').setup {
        filesize = 2, -- in MiB (lowered from 10 for better performance)
        pattern = { '*.log', '*.out.its', 'out.its.*' },
        features = {
          'indent_blankline',
          'illuminate',
          'lsp',
          'treesitter',
          'syntax',
          'matchparen',
          {
            name = 'large_file_options',
            disable = function()
              vim.opt_local.swapfile = false
              vim.opt_local.foldmethod = 'manual'
              vim.opt_local.foldenable = false
              vim.opt_local.undofile = false
              vim.opt_local.undolevels = -1
              vim.opt_local.undoreload = 0
            end,
          },
          'filetype',
        },
      }

      -- Avoid synchronous built-in search counts while a large buffer is active.
      require('config.large-file-search').setup()

      -- Additional optimizations for HUGE files (>100MB)
      vim.api.nvim_create_autocmd({ 'BufReadPre', 'FileReadPre' }, {
        callback = function()
          local file = vim.fn.expand '<afile>'
          local size = vim.fn.getfsize(file)
          -- 100MB threshold for extreme optimizations
          if size > 100 * 1024 * 1024 or size == -2 then
            -- Avoid hashing the entire huge log to look up persistent undo.
            vim.opt_local.undofile = false
            vim.cmd 'syntax off'
            vim.cmd 'filetype off'
            vim.opt_local.foldmethod = 'manual'
            vim.opt_local.foldenable = false
            vim.opt_local.spell = false
            vim.notify('Large file detected (' .. math.floor(size / 1024 / 1024) .. 'MB). Folding and persistent undo disabled.', vim.log.levels.WARN)
          end
        end,
      })
    end,
  },
}
