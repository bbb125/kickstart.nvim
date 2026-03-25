return {
  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-cmdline', -- cmdline completion
      'hrsh7th/cmp-buffer', -- buffer words for search
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-y>'] = cmp.mapping.confirm { select = true },
          ['<CR>'] = cmp.mapping.confirm { select = true },
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        },
        sources = {
          {
            name = 'lazydev',
            group_index = 0,
          },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'nvim_lsp_signature_help' },
        },
      }

      -- Cmdline mappings for : commands (centered popup via noice.nvim)
      -- Up/Down: browse command history when menu is closed, navigate menu when open
      -- Tab/S-Tab: navigate completion menu
      -- <C-y>: confirm selection
      -- <C-e>: abort completion
      -- <CR>: execute command (not mapped here - handled natively)
      local cmdline_mappings = {
        ['<C-n>'] = { c = cmp.mapping.select_next_item() },
        ['<C-p>'] = { c = cmp.mapping.select_prev_item() },
        ['<Tab>'] = { c = cmp.mapping.select_next_item() },
        ['<S-Tab>'] = { c = cmp.mapping.select_prev_item() },
        ['<C-y>'] = { c = cmp.mapping.confirm { select = true } },
        ['<C-e>'] = { c = cmp.mapping.abort() },
        -- Up/Down navigate history when completion menu is closed,
        -- or navigate items when menu is open (like native vim behavior)
        ['<Up>'] = {
          c = function()
            if cmp.visible() then
              cmp.select_prev_item()
            else
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Up>', true, false, true), 'n', false)
            end
          end,
        },
        ['<Down>'] = {
          c = function()
            if cmp.visible() then
              cmp.select_next_item()
            else
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Down>', true, false, true), 'n', false)
            end
          end,
        },
      }

      -- Cmdline completion for ':' commands
      cmp.setup.cmdline(':', {
        mapping = cmdline_mappings,
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        }),
        matching = { disallow_symbol_nonprefix_matching = false },
      })

      -- Cmdline completion for '/' search
      cmp.setup.cmdline('/', {
        mapping = cmdline_mappings,
        sources = {
          { name = 'buffer' },
        },
      })
    end,
  },
}
