-- Ultra-minimal config for HUGE files
-- Usage: nvim -u ~/.config/nvim/minimal.lua huge_file.log
-- Or: alias nf='nvim -u ~/.config/nvim/minimal.lua'

-- Disable all built-in plugins for speed
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

-- Ultra-minimal settings for huge files
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
vim.opt.syntax = 'off'
vim.cmd 'filetype off'
vim.cmd 'syntax off'

-- Minimal useful settings
vim.opt.scrolloff = 5
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Essential keymaps only
vim.g.mapleader = ' '
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

print('⚡ Minimal mode - optimized for huge files')
