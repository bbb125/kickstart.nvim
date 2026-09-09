local M = {}

function M.root()
  local buf = vim.api.nvim_get_current_buf()
  local name = vim.api.nvim_buf_get_name(buf)
  local path = require('config.buffer-policy').is_file(buf) and name ~= '' and name or vim.fn.getcwd()
  return vim.fs.root(path, '.git') or vim.fn.getcwd()
end

function M.open_diff(revision)
  local args = { '-C=' .. M.root() }
  if revision then
    args[#args + 1] = revision
  end
  vim.api.nvim_cmd({ cmd = 'DiffviewOpen', args = args }, {})
end

function M.file_history()
  local buf = vim.api.nvim_get_current_buf()
  local name = vim.api.nvim_buf_get_name(buf)
  if not require('config.buffer-policy').is_file(buf) or name == '' then
    vim.notify('Open a file to show its Git history.', vim.log.levels.INFO)
    return
  end
  vim.api.nvim_cmd({ cmd = 'DiffviewFileHistory', args = { '-C=' .. M.root(), '--', name } }, {})
end

return M
