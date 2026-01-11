-- Ultra-minimal config for HUGE files (>500MB)
-- Usage: nvim -u ~/.config/nvim/minimal.lua huge_file.log
-- Recommended: alias nf='nvim -u ~/.config/nvim/minimal.lua'

-- Disable all built-in plugins for maximum speed
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

-- Ultra-minimal settings
vim.opt.number = false
vim.opt.relativenumber = false
vim.opt.cursorline = false
vim.opt.cursorcolumn = false
vim.opt.signcolumn = 'no'
vim.opt.foldmethod = 'manual'
vim.opt.foldenable = false
vim.opt.list = false
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true

-- Useful settings
vim.opt.scrolloff = 5
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'

-- Disable heavy features
vim.cmd 'syntax off'
vim.cmd 'filetype plugin indent off'

-- Essential keymaps
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { silent = true })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { silent = true })

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move left' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move right' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move down' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move up' })

-- Save
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save', silent = true })

-- Quit
vim.keymap.set('n', '<leader>q', '<cmd>q<CR>', { desc = 'Quit', silent = true })

-- Show file info
vim.keymap.set('n', '<leader>i', function()
  local lines = vim.fn.line '$'
  local size = vim.fn.getfsize(vim.fn.expand '%')
  local size_mb = math.floor(size / 1024 / 1024)
  print(string.format('Lines: %d | Size: %dMB | Minimal Mode', lines, size_mb))
end, { desc = 'File info' })

vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
    print '⚡ Minimal mode (for huge files) | <Space>i for file info | <Space>w to save | <Space>q to quit'
  end,
})
