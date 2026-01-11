-- Performance optimizations for startup and large files

-- Lazy-load expensive plugins only when needed
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    -- Defer loading of UI plugins for faster startup
    vim.defer_fn(function()
      -- These can load after initial display
      pcall(require, 'bufferline')
      pcall(require, 'gitsigns')
    end, 100)
  end,
})

-- Detect huge files early and skip config entirely
local function is_huge_file()
  local file = vim.fn.expand '%'
  if file == '' then
    return false
  end

  local size = vim.fn.getfsize(file)
  -- 500MB threshold for suggesting minimal mode
  if size > 500 * 1024 * 1024 then
    vim.notify(
      string.format(
        'HUGE file detected (%dMB)!\n\nFor faster loading, use:\n  nvim -u ~/.config/nvim/minimal.lua %s\n\nOr add alias:\n  alias nf="nvim -u ~/.config/nvim/minimal.lua"',
        math.floor(size / 1024 / 1024),
        vim.fn.shellescape(file)
      ),
      vim.log.levels.WARN
    )
    return true
  end
  return false
end

-- Check on startup
vim.api.nvim_create_autocmd('BufReadPre', {
  once = true,
  callback = function()
    is_huge_file()
  end,
})

-- Speed up startup by deferring slow operations
vim.defer_fn(function()
  -- Load shada (marks, registers, etc.) after startup
  pcall(vim.cmd, 'rshada')
end, 50)
