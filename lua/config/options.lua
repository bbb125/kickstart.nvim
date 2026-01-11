-- [[ Setting options ]]
-- See `:help vim.opt`

-- Set <space> as the leader key
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Set wide cursor in insert mode
vim.opt.guicursor = 'n-v-c:block,i:block'

-- Column ruler
vim.opt.colorcolumn = '80'

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.equalalways = false

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Disable swap files (we have undofile for crash recovery)
-- This prevents swap file conflicts when LSP jumps to definitions
vim.opt.swapfile = false

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Raise a dialog asking if you wish to save the current file(s)
vim.opt.confirm = true

-- Enable tags for ctags navigation
vim.opt.tags = './tags,tags'

-- Indentation
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true

-- Use Tree-sitter as the folding engine
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- Reasonable default visibility
vim.opt.foldenable = true
vim.opt.foldlevel = 3
vim.opt.foldlevelstart = 2
vim.opt.foldnestmax = 6
vim.opt.foldminlines = 1
vim.opt.foldopen:append 'search' -- open when search lands inside

-- Gutter & symbols
vim.opt.foldcolumn = '1'
vim.opt.fillchars:append {
  fold = ' ',
  foldopen = 'v',
  foldclose = '>',
  eob = ' ',
}

-- Better foldtext: show first nonblank line + line count
function _G.FoldText()
  local fs, fe = vim.v.foldstart, vim.v.foldend
  local line = vim.api.nvim_buf_get_lines(0, fs - 1, fs, false)[1] or ''
  local indent = line:match '^%s*' or ''
  local count = fe - fs + 1
  line = line:gsub('^%s+', ''):gsub('\t', '  ')
  return string.format('%s %s  … [%d lines]', indent, line, count)
end
vim.opt.foldtext = 'v:lua.FoldText()'

-- Set the quickfix text function
function _G.MyQuickfixTextFunc(info)
  local items = vim.fn.getqflist()
  local lines = {}
  local last_file = nil
  for _, item in ipairs(items) do
    local file = ''
    if not item.bufnr or item.bufnr == '' then
      file = '[No Name]'
    else
      file = vim.fn.fnamemodify(item.bufnr, ':t')
    end

    local display_file = ''
    if file ~= last_file then
      display_file = file
      last_file = file
    end

    local lnum = item.lnum or 0
    local col = item.col or 0
    local text = item.text or ''
    table.insert(lines, string.format('%4d:%-3d\t%s', lnum, col, text))
  end
  return lines
end
vim.opt.quickfixtextfunc = 'v:lua.MyQuickfixTextFunc'

-- Required for opencode opts.events.reload
vim.o.autoread = true

-- Neovide specific settings
if vim.g.neovide then
  -- Transparency settings (use either neovide_transparency or neovide_opacity, not both)
  vim.g.neovide_transparency = 0.8
  vim.g.neovide_window_blurred = false

  -- Animation settings
  vim.g.neovide_cursor_animation_length = 0 -- 0.150
  vim.g.neovide_scroll_animation_length = 0.1 -- try 0 or 0.10
  vim.g.neovide_position_animation_length = 0.1 -- window movement/resizing

  -- Set GUI font
  vim.opt.guifont = 'JetBrainsMono Nerd Font:h10'
end
