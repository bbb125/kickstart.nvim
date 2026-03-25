-- [[ Basic Autocommands ]]
-- See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Compute Server log files
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.out.its', 'out.its.*' },
  callback = function()
    vim.opt_local.filetype = 'log'
  end,
})

-- Disable LSP for special buffer types (lazygit, diffview, fugitive, etc.)
-- Prevents LSP from flooding messages when these tools open temporary buffers
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Disable LSP for non-code buffer types',
  group = vim.api.nvim_create_augroup('disable-lsp-special-bufs', { clear = true }),
  pattern = {
    'DiffviewFiles',
    'DiffviewFileHistory',
    'fugitive',
    'git',
    'gitcommit',
    'gitrebase',
  },
  callback = function(args)
    vim.schedule(function()
      -- Detach all LSP clients from this buffer
      local clients = vim.lsp.get_clients({ bufnr = args.buf })
      for _, client in ipairs(clients) do
        vim.lsp.buf_detach_client(args.buf, client.id)
      end
    end)
  end,
})

-- Disable diagnostics in terminal buffers (lazygit, toggleterm, etc.)
vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Disable diagnostics in terminal buffers',
  group = vim.api.nvim_create_augroup('disable-diag-terminal', { clear = true }),
  callback = function(args)
    vim.diagnostic.enable(false, { bufnr = args.buf })
  end,
})
