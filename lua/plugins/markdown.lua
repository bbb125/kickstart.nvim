return {
  { -- Markdown preview and enhanced rendering
    'MeanderingProgrammer/render-markdown.nvim',
    ft = 'markdown',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      file_types = { 'markdown' },
      render_modes = { 'n', 'c' },
      anti_conceal = { enabled = false }, -- Stable reading view; Insert mode shows source.
      heading = { sign = false, width = 'block', right_pad = 2 },
      code = { sign = false, width = 'block', left_pad = 1, right_pad = 1 },
      pipe_table = { preset = 'round', style = 'full' },
      win_options = {
        conceallevel = { default = 0, rendered = 3 },
        concealcursor = { default = '', rendered = 'nc' },
        wrap = { default = vim.o.wrap, rendered = true },
        linebreak = { default = vim.o.linebreak, rendered = true },
        colorcolumn = { default = vim.o.colorcolumn, rendered = '' },
        number = { default = vim.o.number, rendered = false },
        relativenumber = { default = vim.o.relativenumber, rendered = false },
        foldenable = { default = vim.o.foldenable, rendered = false },
      },
    },
    keys = {
      {
        '<leader>tm',
        '<cmd>RenderMarkdown toggle<cr>',
        desc = '[T]oggle [M]arkdown rendering',
      },
    },
  },

  { -- Markdown table mode
    'dhruvasagar/vim-table-mode',
    ft = 'markdown',
    config = function()
      vim.g.table_mode_corner = '|'
      vim.g.table_mode_header_fillchar = '-'
    end,
    keys = {
      {
        '<leader>tt',
        '<cmd>TableModeToggle<cr>',
        desc = '[T]oggle [T]able mode',
        ft = 'markdown',
      },
    },
  },

  { -- Markdown TOC generation
    'hedyhli/markdown-toc.nvim',
    ft = 'markdown',
    cmd = { 'Mtoc' },
    opts = {},
  },
}
