-- [[ Basic Keymaps ]]
-- See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Close tab
vim.keymap.set('n', '<leader>wc', ':tabclose<CR>', { desc = '[W]indow/tab [C]lose', noremap = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Open explorer
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> or CTRL+arrows to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<C-Left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-Right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-Down>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-Up>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Tab navigation with Ctrl+Shift+Left/Right
vim.keymap.set('n', '<C-S-Left>', '<cmd>tabprevious<CR>', { desc = 'Previous tab' })
vim.keymap.set('n', '<C-S-Right>', '<cmd>tabnext<CR>', { desc = 'Next tab' })

-- Toggle zoom current split (maximize/restore)
vim.keymap.set('n', '<C-w>z', function()
  if vim.t.zoomed then
    vim.cmd 'tabclose'
  else
    vim.cmd 'tab split'
    vim.t.zoomed = true
  end
end, { desc = 'Toggle zoom current split' })
vim.keymap.set('n', '<leader>z', function()
  if vim.t.zoomed then
    vim.cmd 'tabclose'
  else
    vim.cmd 'tab split'
    vim.t.zoomed = true
  end
end, { desc = '[Z]oom toggle current split' })

-- Fold keymaps
vim.keymap.set('n', 'zp', function()
  local fs, fe = vim.v.foldstart, vim.v.foldend
  local lines = vim.api.nvim_buf_get_lines(0, fs - 1, fe, false)

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  local width = math.floor(vim.o.columns * 0.6)
  local height = math.min(#lines, math.floor(vim.o.lines * 0.4))
  local opts = {
    relative = 'editor',
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    style = 'minimal',
    border = 'rounded',
  }
  vim.api.nvim_open_win(buf, true, opts)
end, { desc = 'Peek fold in floating window' })

vim.keymap.set('n', '<CR>', function()
  -- Keep Enter working in quickfix/location-list
  if vim.bo.buftype == 'quickfix' then
    return '<CR>'
  end

  local l = vim.fn.line '.'
  local fl = vim.fn.foldlevel(l)

  -- If we're on a fold, toggle it
  if fl > 0 then
    if vim.fn.foldclosed(l) == -1 then
      return 'zc' -- close
    else
      return 'zo' -- open
    end
  end

  -- Otherwise keep Neovim's default <CR> in normal mode (same as "j")
  return 'j'
end, { expr = true, silent = true })

vim.keymap.set('n', 'zR', 'zR', { desc = 'Open all folds' })
vim.keymap.set('n', 'zM', 'zM', { desc = 'Close all folds' })
