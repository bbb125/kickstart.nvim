local M = {}

function M.is_file(buf)
  return vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == '' and not vim.api.nvim_buf_get_name(buf):match '^%a[%w+.-]*://'
end

function M.can_parse(buf)
  return M.is_file(buf) and not require('config.large-file-search').is_large(buf)
end

function M.setup_folds()
  local group = vim.api.nvim_create_augroup('CodeFolds', { clear = true })
  vim.api.nvim_create_autocmd({ 'FileType', 'BufWinEnter' }, {
    group = group,
    callback = function(args)
      if args.buf ~= vim.api.nvim_get_current_buf() or vim.wo.diff then
        return
      end
      if not M.can_parse(args.buf) or vim.bo[args.buf].filetype == 'markdown' then
        vim.wo.foldmethod = 'manual'
        return
      end
      local ok, parser = pcall(vim.treesitter.get_parser, args.buf)
      vim.wo.foldmethod = ok and parser and 'expr' or 'manual'
    end,
  })
end

-- Guard before LSP activation: detaching at LspAttach is too late to prevent didOpen.
function M.lsp_root(config)
  local original = config.root_dir
  return function(buf, on_dir)
    if not M.can_parse(buf) then
      return
    end
    if type(original) == 'function' then
      return original(buf, on_dir)
    end
    local root = original or vim.fs.root(buf, config.root_markers or { '.git' })
    if root or not config.workspace_required then
      on_dir(root)
    end
  end
end

return M
