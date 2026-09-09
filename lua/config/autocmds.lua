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

-- Disable diagnostics in terminal buffers (lazygit, toggleterm, etc.)
vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Disable diagnostics in terminal buffers',
  group = vim.api.nvim_create_augroup('disable-diag-terminal', { clear = true }),
  callback = function(args)
    vim.diagnostic.enable(false, { bufnr = args.buf })
  end,
})
