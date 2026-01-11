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
      code = {
        enabled = true,
        sign = true,
        style = 'full',
        position = 'left',
        width = 'full',
        left_pad = 0,
        right_pad = 0,
        min_width = 0,
        border = 'thin',
        above = '▄',
        below = '▀',
        highlight = 'RenderMarkdownCode',
      },
      heading = {
        enabled = true,
        sign = true,
        icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
        backgrounds = {
          'RenderMarkdownH1Bg',
          'RenderMarkdownH2Bg',
          'RenderMarkdownH3Bg',
          'RenderMarkdownH4Bg',
          'RenderMarkdownH5Bg',
          'RenderMarkdownH6Bg',
        },
      },
      bullet = {
        enabled = true,
        icons = { '●', '○', '◆', '◇' },
      },
      checkbox = {
        enabled = true,
        unchecked = { icon = '󰄱 ' },
        checked = { icon = '󰱒 ' },
        custom = {
          todo = { raw = '[-]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo' },
        },
      },
      quote = {
        enabled = true,
        icon = '▋',
      },
      pipe_table = {
        enabled = true,
        style = 'full',
      },
      callout = {
        note = { raw = '[!NOTE]', rendered = '󰋽 Note', highlight = 'RenderMarkdownInfo' },
        tip = { raw = '[!TIP]', rendered = '󰌶 Tip', highlight = 'RenderMarkdownSuccess' },
        important = { raw = '[!IMPORTANT]', rendered = '󰅾 Important', highlight = 'RenderMarkdownHint' },
        warning = { raw = '[!WARNING]', rendered = '󰀪 Warning', highlight = 'RenderMarkdownWarn' },
        caution = { raw = '[!CAUTION]', rendered = '󰳦 Caution', highlight = 'RenderMarkdownError' },
        abstract = { raw = '[!ABSTRACT]', rendered = '󰨸 Abstract', highlight = 'RenderMarkdownInfo' },
        todo = { raw = '[!TODO]', rendered = '󰥔 Todo', highlight = 'RenderMarkdownInfo' },
      },
      link = {
        enabled = true,
        image = '󰥶 ',
        hyperlink = '󰌹 ',
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
