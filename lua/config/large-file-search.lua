local M = {}
local count_flag_added = false

function M.is_large(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  if vim.b[buf].bigfile_detected == 1 then
    return true
  end
  local lines = vim.api.nvim_buf_line_count(buf)
  -- Bound completion indexing for both long lines and many short lines.
  return lines > 20000 or vim.api.nvim_buf_get_offset(buf, lines) >= 2 * 1024 * 1024
end

function M.completion_buffers()
  local buf = vim.api.nvim_get_current_buf()
  return M.is_large(buf) and {} or { buf }
end

function M.sync_search_count()
  if M.is_large() then
    if not vim.o.shortmess:find('S', 1, true) then
      vim.opt.shortmess:append('S')
      count_flag_added = true
    end
  elseif count_flag_added then
    vim.opt.shortmess:remove('S')
    count_flag_added = false
  end
end

function M.setup()
  local group = vim.api.nvim_create_augroup('LargeFileSearch', { clear = true })
  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter', 'BufReadPost' }, {
    group = group,
    callback = M.sync_search_count,
  })
  M.sync_search_count()
end

return M
