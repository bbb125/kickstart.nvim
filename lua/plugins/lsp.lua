return {
  { -- Lua LSP for Neovim config
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  { -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', opts = {} },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Diagnostic Config
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            return diagnostic.message
          end,
        },
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {
        clangd = {
          cmd = {
            'clangd',
            '--background-index',
            '--clang-tidy',
            '--header-insertion=iwyu',
            '--completion-style=detailed',
            '--function-arg-placeholders',
            '--fallback-style=llvm',
            '--query-driver=/opt/homebrew/Cellar/llvm/*/bin/clang*,/opt/homebrew/Cellar/gcc/*/bin/g++-*,/opt/homebrew/bin/g++-*,/usr/bin/clang*,/usr/bin/g++*',
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
            -- Search these directories for compile_commands.json (in order)
            -- cmake-tools.nvim creates a symlink in project root, but these are fallbacks
            compilationDatabasePath = '',
            fallbackFlags = { '-std=c++20' },
          },
          -- Function to find compile_commands.json in common locations
          on_new_config = function(new_config, root_dir)
            local util = require 'lspconfig.util'
            -- Common build directories to search (in order of preference)
            local build_dirs = {
              root_dir, -- Project root (cmake-tools creates symlink here)
              root_dir .. '/build',
              root_dir .. '/build/Release',
              root_dir .. '/build/Debug',
              root_dir .. '/build/RelWithDebInfo',
              root_dir .. '/cmake-build-debug',
              root_dir .. '/cmake-build-release',
              root_dir .. '/out/build',
            }

            for _, dir in ipairs(build_dirs) do
              local compile_commands = dir .. '/compile_commands.json'
              if vim.fn.filereadable(compile_commands) == 1 then
                -- Add --compile-commands-dir flag
                new_config.cmd = vim.list_extend(vim.deepcopy(new_config.cmd), {
                  '--compile-commands-dir=' .. dir,
                })
                break
              end
            end
          end,
        },
        cmake = {},
        ocaml_ls = {
          cmd = { 'ocamllsp' },
        },
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
        pyright = {
          settings = {
            pyright = {
              disableOrganizeImports = true, -- Using ruff for imports
            },
            python = {
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = 'openFilesOnly',
                useLibraryCodeForTypes = true,
                typeCheckingMode = 'basic',
              },
            },
          },
        },
        ruff = {}, -- Fast Python linter (replaces flake8, isort, etc.)
        harper_ls = {
          filetypes = { 'markdown', 'gitcommit', 'text' },
          settings = {
            ['harper-ls'] = {
              linters = {
                spell_check = true,
                spelled_numbers = false,
                an_a = true,
                sentence_capitalization = true,
                unclosed_quotes = true,
                wrong_quotes = false,
                long_sentences = true,
                repeated_words = true,
                spaces = true,
                matcher = true,
                correct_number_suffix = true,
                number_suffix_capitalization = true,
                multiple_sequential_pronouns = true,
              },
              codeActions = {
                forceStable = true,
              },
            },
          },
        },
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      -- Filter out servers that can't/shouldn't be installed via Mason
      -- (use system versions on Linux with older glibc, or when already available)
      local skip_mason = { 'ocaml_ls' }
      -- On Linux, prefer system clangd and skip harper_ls if glibc is old
      if vim.fn.has 'linux' == 1 then
        if vim.fn.executable 'clangd' == 1 then
          table.insert(skip_mason, 'clangd')
        end
        -- harper_ls often has glibc issues on older Linux
        table.insert(skip_mason, 'harper_ls')
      end
      ensure_installed = vim.tbl_filter(function(server)
        return not vim.tbl_contains(skip_mason, server)
      end, ensure_installed)
      vim.list_extend(ensure_installed, {
        'stylua',
        -- Python tools
        'black', -- Formatter
        'isort', -- Import sorter
        'debugpy', -- Python debugger
        'mypy', -- Type checker
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {},
        automatic_installation = false,
        automatic_enable = true,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }

      -- Disable stylua LSP (it's a formatter, not an LSP server)
      vim.lsp.enable('stylua', false)

      -- Manually set up servers skipped from Mason (using system binaries)
      for _, server_name in ipairs(skip_mason) do
        if servers[server_name] and vim.fn.executable(server_name:gsub('_', '-')) == 1 then
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
          -- Enable auto-start for Neovim 0.11+
          if vim.fn.has 'nvim-0.11' == 1 then
            vim.lsp.enable(server_name)
          end
        end
      end
    end,
  },

  { -- clangd extensions for C/C++
    'p00f/clangd_extensions.nvim',
    lazy = true,
    ft = { 'c', 'cpp', 'objc', 'objcpp' },
    opts = {
      inlay_hints = {
        inline = true,
      },
      ast = {
        role_icons = {
          type = '',
          declaration = '',
          expression = '',
          specifier = '',
          statement = '',
          ['template argument'] = '',
        },
      },
    },
    config = function(_, opts)
      require('clangd_extensions').setup(opts)
      vim.keymap.set('n', '<leader>ch', '<cmd>ClangdSwitchSourceHeader<cr>', { desc = '[C]langd Switch [H]eader/Source' })
    end,
  },
}
