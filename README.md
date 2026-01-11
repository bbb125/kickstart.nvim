# Modern Neovim Configuration

A modern, modular Neovim configuration optimized for C++, Lua, and general development.

## 📁 Structure

```
~/.config/nvim/
├── init.lua                    # Entry point (bootstraps config)
├── lua/
│   ├── config/                 # Core configuration
│   │   ├── options.lua        # All vim.opt settings
│   │   ├── keymaps.lua        # Basic keymaps
│   │   ├── autocmds.lua       # Autocommands
│   │   └── lazy.lua           # Plugin manager setup
│   ├── plugins/               # Plugin specifications (auto-loaded)
│   │   ├── ai.lua             # opencode.nvim & snacks.nvim
│   │   ├── colorscheme.lua    # kanagawa theme
│   │   ├── completion.lua     # nvim-cmp & snippets
│   │   ├── debug.lua          # nvim-dap
│   │   ├── editor.lua         # treesitter, mini.nvim, etc.
│   │   ├── file-explorer.lua  # nvim-tree & oil.nvim
│   │   ├── formatting.lua     # conform.nvim
│   │   ├── git.lua            # gitsigns
│   │   ├── jira.lua           # jira.nvim
│   │   ├── lsp.lua            # Full LSP config
│   │   ├── modern-enhancements.lua  # flash, trouble, etc.
│   │   ├── telescope.lua      # Fuzzy finder
│   │   └── ui.lua             # which-key, bufferline
│   └── kickstart/             # Kickstart.nvim modules
│       └── plugins/
│           ├── autopairs.lua
│           └── gitsigns.lua
└── queries/                   # Custom treesitter queries
    └── cpp/folds.scm         # C++ folding rules
```

## 🚀 Core Plugins

### Editor Enhancements
- **[lazy.nvim](https://github.com/folke/lazy.nvim)** - Fast plugin manager
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** - Syntax highlighting & parsing
- **[nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context)** - Shows code context at top
- **[flash.nvim](https://github.com/folke/flash.nvim)** - Fast motion/jumping
- **[mini.nvim](https://github.com/echasnovski/mini.nvim)** - Collection of small plugins (ai, surround, statusline)
- **[todo-comments.nvim](https://github.com/folke/todo-comments.nvim)** - Highlight TODO/FIXME/etc
- **[marks.nvim](https://github.com/chentoast/marks.nvim)** - Better mark visualization

### LSP & Completion
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** - LSP client configurations
- **[mason.nvim](https://github.com/williamboman/mason.nvim)** - LSP/tool installer
- **[clangd_extensions.nvim](https://github.com/p00f/clangd_extensions.nvim)** - C/C++ enhancements
- **[nvim-cmp](https://github.com/hrsh7th/nvim-cmp)** - Autocompletion
- **[LuaSnip](https://github.com/L3MON4D3/LuaSnip)** - Snippet engine
- **[lazydev.nvim](https://github.com/folke/lazydev.nvim)** - Lua LSP for Neovim config
- **[fidget.nvim](https://github.com/j-hui/fidget.nvim)** - LSP progress UI

### File Navigation
- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)** - Fuzzy finder
- **[nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)** - File tree explorer
- **[oil.nvim](https://github.com/stevearc/oil.nvim)** - Buffer-based file editing

### Git Integration
- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)** - Git decorations
- **[snacks.nvim](https://github.com/folke/snacks.nvim)** - Includes lazygit integration

### UI/UX
- **[which-key.nvim](https://github.com/folke/which-key.nvim)** - Keybinding helper
- **[bufferline.nvim](https://github.com/akinsho/bufferline.nvim)** - Buffer tabs
- **[trouble.nvim](https://github.com/folke/trouble.nvim)** - Better diagnostics list
- **[dressing.nvim](https://github.com/stevearc/dressing.nvim)** - Better UI for select/input
- **[kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim)** - Colorscheme

### Utilities
- **[conform.nvim](https://github.com/stevearc/conform.nvim)** - Formatter
- **[persistence.nvim](https://github.com/folke/persistence.nvim)** - Session management
- **[bigfile.nvim](https://github.com/LunarVim/bigfile.nvim)** - Performance for large files
- **[nvim-autopairs](https://github.com/windwp/nvim-autopairs)** - Auto close brackets

### AI/Productivity
- **[opencode.nvim](https://github.com/NickvanDyke/opencode.nvim)** - AI code assistant
- **[snacks.nvim](https://github.com/folke/snacks.nvim)** - Multi-purpose utilities
- **[jira.nvim](https://github.com/letieu/jira.nvim)** - Jira integration

## ⌨️ Key Mappings

### Leader Key
- **Leader**: `<Space>`
- **Local Leader**: `<Space>`

### General

| Key | Action | Mode |
|-----|--------|------|
| `<Esc>` | Clear search highlights | Normal |
| `<leader>wc` | Close tab/window | Normal |
| `<C-h/j/k/l>` | Navigate windows | Normal |
| `<Esc><Esc>` | Exit terminal mode | Terminal |

### File Navigation (Telescope)

| Key | Action |
|-----|--------|
| `<leader>sf` | Search files |
| `<C-P>` | Search git files |
| `<leader>sg` | Live grep |
| `<leader>sw` | Search current word |
| `<leader>sh` | Search help |
| `<leader>sk` | Search keymaps |
| `<leader>sr` | Resume last search |
| `<leader>s.` | Recent files |
| `<leader>st` | Search tags |
| `<leader>sn` | Search Neovim config files |
| `<leader><leader>` | Find buffers |
| `<leader>/` | Fuzzy search in current buffer |

### LSP

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `gD` | Go to declaration |
| `<leader>D` | Type definition |
| `<leader>ds` | Document symbols |
| `<leader>ws` | Workspace symbols |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>th` | Toggle inlay hints |
| `<leader>ch` | Switch header/source (C++) |

### Diagnostics & Quickfix (Trouble)

| Key | Action |
|-----|--------|
| `<leader>xx` | Toggle diagnostics |
| `<leader>xX` | Buffer diagnostics |
| `<leader>cs` | Symbols (Trouble) |
| `<leader>cl` | LSP references (Trouble) |
| `<leader>xL` | Location list |
| `<leader>xQ` | Quickfix list |
| `<leader>q` | Diagnostic quickfix list |

### Motion (Flash)

| Key | Action | Mode |
|-----|--------|------|
| `s` | Flash jump | Normal, Visual, Operator |
| `S` | Flash Treesitter | Normal, Visual, Operator |
| `r` | Remote Flash | Operator |
| `R` | Treesitter Search | Operator, Visual |

### Git (Snacks & Gitsigns)

| Key | Action |
|-----|--------|
| `<leader>gg` | Open lazygit |
| `<leader>gb` | Git blame line |
| `<leader>gB` | Git browse (open in browser) |
| `<leader>gf` | File history in lazygit |
| `<leader>gl` | Git log (cwd) |

### Sessions (Persistence)

| Key | Action |
|-----|--------|
| `<leader>qs` | Restore session |
| `<leader>qS` | Select session |
| `<leader>ql` | Restore last session |
| `<leader>qd` | Don't save current session |

### Buffer & UI

| Key | Action |
|-----|--------|
| `<leader>bd` | Delete buffer (smart) |
| `<leader>f` | Format buffer |
| `<leader>un` | Dismiss all notifications |
| `<leader>tc` | Toggle treesitter context |
| `<leader>cR` | Rename file |

### Folding

| Key | Action |
|-----|--------|
| `<CR>` | Toggle fold under cursor |
| `zp` | Peek fold in floating window |
| `zR` | Open all folds |
| `zM` | Close all folds |

### AI (OpenCode)

| Key | Action | Mode |
|-----|--------|------|
| `<C-a>` | Ask opencode | Normal, Visual |
| `<C-x>` | Execute opencode action | Normal, Visual |
| `<C-.>` | Toggle opencode | Normal, Terminal |
| `go` | Add range to opencode | Normal, Visual |
| `goo` | Add line to opencode | Normal |
| `+` | Increment (remapped from `<C-a>`) | Normal |
| `-` | Decrement (remapped from `<C-x>`) | Normal |

### Word Navigation (Snacks)

| Key | Action | Mode |
|-----|--------|------|
| `]]` | Next word reference | Normal, Terminal |
| `[[` | Previous word reference | Normal, Terminal |

## 🎨 Colorscheme

**Kanagawa** with transparent background
- Dark theme inspired by famous painting "The Great Wave off Kanagawa"
- Custom ColorColumn highlighting (darker than CursorLine)

## 🛠️ LSP Servers Configured

- **clangd** - C/C++ (with extensive flags for tsi-logger project)
- **cmake** - CMake
- **ocaml_ls** - OCaml (installed via opam, not Mason)
- **lua_ls** - Lua

## 📝 Formatters

- **stylua** - Lua
- **clang-format** - C/C++
- **isort + black** - Python
- **prettier/prettierd** - JavaScript

## ⚙️ Special Features

### Folding
- Treesitter-based folding
- Custom C++ fold queries in `queries/cpp/folds.scm`
- Fold peek with `zp`
- Smart `<CR>` toggle in folds

### Performance
- **bigfile.nvim**: Disables heavy features for files >10MB
- **No swap files**: Uses undofile for crash recovery instead
- **Lazy loading**: Most plugins load on demand

### File Type Specific
- C/C++ files treated as C++ by treesitter
- `*.out.its` and `out.its.*` files treated as log files
- Custom clangd query-driver for homebrew gcc/clang

### Neovide Support
- Custom transparency settings
- Optimized animation lengths
- JetBrainsMono Nerd Font

## 🔧 Customization

To customize, edit files in `lua/config/` and `lua/plugins/`:

- **Options**: `lua/config/options.lua`
- **Keymaps**: `lua/config/keymaps.lua`
- **New plugin**: Create file in `lua/plugins/` (auto-loaded)
- **LSP servers**: Edit `lua/plugins/lsp.lua`

## 📦 Installation

1. Backup existing config:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

2. Clone this config:
   ```bash
   git clone <your-repo-url> ~/.config/nvim
   ```

3. Start Neovim:
   ```bash
   nvim
   ```
   Lazy.nvim will automatically install all plugins.

4. Run health check:
   ```
   :checkhealth
   ```

## 🔍 Useful Commands

- `:Lazy` - Plugin manager UI
- `:Mason` - LSP/tool installer UI
- `:Telescope` - Open telescope picker
- `:Trouble` - Toggle diagnostics
- `:ConformInfo` - Check formatter status
- `:checkhealth` - Health check

## 📚 Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [nvim-lspconfig Server Configurations](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)
- [Treesitter Playground](https://github.com/nvim-treesitter/playground)

## 🙏 Credits

Based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) with extensive modernization and customization.

---

**Last Updated**: January 2026

## 🐛 Known Issues

### Stylua LSP Error
If you see "Client stylua quit with exit code 2" errors, this is harmless. Stylua is a formatter (used via conform.nvim), not an LSP server. The error occurs when Mason tries to auto-configure it as an LSP. Formatting still works correctly via `<leader>f`.

To silence these errors, the stylua LSP is disabled in the configuration.
