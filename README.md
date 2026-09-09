> September 2026: see [CONFIG-AUDIT.md](CONFIG-AUDIT.md) for the current architecture, repaired API mismatches, Markdown controls, and tested upgrade choices. Older benchmark numbers below are historical.

# Modern Neovim Configuration

A modern, modular Neovim configuration optimized for C++, Python, Rust, Lua, and general development.

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
│   │   ├── cmake.lua          # cmake-tools, overseer, toggleterm
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
│   │   ├── python.lua         # Python development (venv, testing, debug)
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
- **[indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)** - Indent guides with scope highlighting

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
- **[diffview.nvim](https://github.com/sindrets/diffview.nvim)** - Side-by-side diff view for commits and file history
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
- **[grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim)** - Fast search and replace across files
- **[undotree](https://github.com/mbbill/undotree)** - Visualize undo history
- **[harpoon](https://github.com/ThePrimeagen/harpoon)** - Quick file navigation (mark & jump)
- **[noice.nvim](https://github.com/folke/noice.nvim)** - Modern UI for cmdline, messages, notifications
- **[neorg](https://github.com/nvim-neorg/neorg)** - Org-mode for Neovim (notes, todos)
- **[refactoring.nvim](https://github.com/ThePrimeagen/refactoring.nvim)** - Extract function/variable, inline, etc.
- **[legendary.nvim](https://github.com/mrjones2014/legendary.nvim)** - Searchable palette for keymaps, commands, autocmds

### AI/Productivity
- **[opencode.nvim](https://github.com/NickvanDyke/opencode.nvim)** - AI code assistant
- **[snacks.nvim](https://github.com/folke/snacks.nvim)** - Multi-purpose utilities
- **[jira.nvim](https://github.com/letieu/jira.nvim)** - Jira integration

### Rust Development
- **[rustaceanvim](https://github.com/mrcjkb/rustaceanvim)** - Modern Rust plugin with LSP, DAP, and tools
- **[crates.nvim](https://github.com/saecki/crates.nvim)** - Cargo.toml dependency management

### Python Development
- **[pyright](https://github.com/microsoft/pyright)** - Fast Python type checker and language server
- **[ruff](https://github.com/astral-sh/ruff)** - Ultra-fast Python linter and formatter
- **[venv-selector.nvim](https://github.com/linux-cultist/venv-selector.nvim)** - Virtual environment picker
- **[neotest](https://github.com/nvim-neotest/neotest)** - Test runner framework with pytest adapter
- **[nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python)** - Python debugging with debugpy

### Debugging
- **[nvim-dap](https://github.com/mfussenegger/nvim-dap)** - Debug Adapter Protocol client
- **[nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)** - UI for nvim-dap
- **[nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text)** - Virtual text during debugging

### Build & Task Running
- **[cmake-tools.nvim](https://github.com/Civitasv/cmake-tools.nvim)** - Full CMake workflow (presets, targets, build, debug)
- **[overseer.nvim](https://github.com/stevearc/overseer.nvim)** - General task runner (supports Make, Cargo, npm, Go, etc.)
- **[toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)** - Terminal management

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
| `<C-Left/Right/Up/Down>` | Navigate windows (arrow keys) | Normal |
| `<C-S-Left>` / `<C-S-Right>` | Previous/next tab | Normal |
| `<C-w>z` or `<leader>z` | Toggle zoom current split | Normal |
| `<Esc><Esc>` | Exit terminal mode | Terminal |

### File Explorer (nvim-tree)

| Key | Action |
|-----|--------|
| `<leader>ef` | Reveal current file in tree (stay in buffer) |
| `<leader>eF` | Reveal current file in tree and focus |

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

**Popular shortcuts (also available under `<leader>l`):**

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `gD` | Go to declaration |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>ch` | Switch header/source (C++) |

**Full LSP menu (`<leader>l`):**

| Key | Action |
|-----|--------|
| `<leader>ld` | Definition |
| `<leader>lr` | References |
| `<leader>li` | Implementation |
| `<leader>lD` | Declaration |
| `<leader>lt` | Type definition |
| `<leader>ls` | Document symbols |
| `<leader>lS` | Workspace symbols |
| `<leader>ln` | Rename |
| `<leader>la` | Code action |
| `<leader>lh` | Toggle inlay hints |
| `<leader>lR` | Restart LSP |

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

### Git (Snacks, Gitsigns & Diffview)

| Key | Action |
|-----|--------|
| `<leader>gg` | Open lazygit |
| `<leader>gb` | Git blame line |
| `<leader>gB` | Git browse (open in browser) |
| `<leader>gf` | File history in lazygit |
| `<leader>gl` | Git log (cwd) |
| `<leader>gd` | Diff view (working changes) |
| `<leader>gc` | Pick commit to view in diff |
| `<leader>gh` | File history (current file) |
| `<leader>gH` | File history (all files) |
| `<leader>gq` | Close diff view |

### Sessions (Persistence)

| Key | Action |
|-----|--------|
| `<leader>qs` | Restore session |
| `<leader>qS` | Select session |
| `<leader>ql` | Restore last session |
| `<leader>qd` | Don't save current session |

### Command Palette (legendary)

| Key | Action |
|-----|--------|
| `<leader>P` | Open command palette (keymaps + commands) |
| `<leader>?` | Search all keymaps |

### Search & Replace (grug-far)

| Key | Action |
|-----|--------|
| `<leader>S` | Open search and replace |
| `<leader>S` (visual) | Search selected text |

### Undo Tree

| Key | Action |
|-----|--------|
| `<leader>U` | Toggle undo tree |

### Harpoon (Quick File Navigation)

| Key | Action |
|-----|--------|
| `<leader>ha` | Add current file to harpoon |
| `<leader>hh` | Open harpoon menu |
| `<leader>1-4` | Jump to harpoon file 1-4 |
| `<leader>hp` | Previous harpoon file |
| `<leader>hn` | Next harpoon file |

### Command Line & Search (noice.nvim)

**`:` commands** use a centered floating popup with autocompletion:

| Key | Action |
|-----|--------|
| `<Up>` / `<Down>` | Browse command history (or navigate completion menu if open) |
| `<Tab>` / `<S-Tab>` | Navigate completion suggestions |
| `<C-n>` / `<C-p>` | Navigate completion suggestions |
| `<C-y>` | Confirm completion selection |
| `<C-e>` | Dismiss completion menu |
| `<CR>` | Execute command |

**`/` and `?` search** uses the same centered popup with buffer word completion:

| Key | Action |
|-----|--------|
| `<Up>` / `<Down>` | Browse search history (or navigate completion menu if open) |
| `<Tab>` / `<S-Tab>` | Navigate buffer word completions |
| `<C-e>` | Dismiss completion menu |
| `<CR>` | Execute search |

### Noice (Notifications)

| Key | Action |
|-----|--------|
| `<leader>nd` | Dismiss notifications |
| `<leader>nl` | Show last message |
| `<leader>nh` | Show message history |

### Neorg (Notes)

| Key | Action |
|-----|--------|
| `<leader>ni` | Open neorg index |
| `<leader>nw` | Switch workspace |
| `<leader>nj` | Open today's journal |
| `<leader>nr` | Return to previous buffer |

### Refactoring (Visual Mode)

| Key | Action |
|-----|--------|
| `<leader>re` | Extract function |
| `<leader>rf` | Extract function to file |
| `<leader>rv` | Extract variable |
| `<leader>ri` | Inline variable |
| `<leader>rI` | Inline function |
| `<leader>rb` | Extract block |
| `<leader>rr` | Refactor menu |

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

### Rust Development (RustaceanVim)

| Key | Action |
|-----|--------|
| `<leader>rr` | Run runnables |
| `<leader>rd` | Run debuggables |
| `<leader>rt` | Run testables |
| `<leader>re` | Expand macro |
| `<leader>rc` | Open Cargo.toml |
| `<leader>rp` | Go to parent module |
| `<leader>rj` | Join lines |
| `<leader>rh` | Hover actions |
| `<leader>rm` | Rebuild proc macros |
| `K` | Hover actions (in Rust files) |

### Cargo.toml (Crates.nvim)

| Key | Action |
|-----|--------|
| `<leader>ct` | Toggle crates |
| `<leader>cr` | Reload crates |
| `<leader>cv` | Show versions popup |
| `<leader>cf` | Show features popup |
| `<leader>cd` | Show dependencies popup |
| `<leader>cu` | Update crate |
| `<leader>ca` | Update all crates |
| `<leader>cU` | Upgrade crate |
| `<leader>cA` | Upgrade all crates |
| `<leader>cH` | Open crate homepage |
| `<leader>cR` | Open crate repository |
| `<leader>cD` | Open crate documentation |
| `<leader>cC` | Open crates.io page |

### Python Development

| Key | Action |
|-----|--------|
| `<leader>pv` | Select Python virtual environment |
| `<leader>pc` | Use cached virtual environment |
| `<leader>tt` | Run nearest test |
| `<leader>tf` | Run tests in current file |
| `<leader>ts` | Toggle test summary panel |
| `<leader>to` | Show test output |
| `<leader>tO` | Toggle test output panel |
| `<leader>td` | Debug nearest test |
| `<leader>tS` | Stop running tests |
| `[t` | Jump to previous failed test |
| `]t` | Jump to next failed test |
| `<leader>dpm` | Debug Python method |
| `<leader>dpc` | Debug Python class |
| `<leader>dps` | Debug Python selection |

### CMake (cmake-tools.nvim)

| Key | Action |
|-----|--------|
| `<leader>mg` | CMake Generate (configure with preset) |
| `<leader>mb` | CMake Build |
| `<leader>mr` | CMake Run |
| `<leader>md` | CMake Debug |
| `<leader>mt` | Select build target |
| `<leader>ml` | Select launch target |
| `<leader>mp` | Select configure preset |
| `<leader>mP` | Select build preset |
| `<leader>mD` | Select build directory (for custom setups) |
| `<leader>mT` | Select build type (Debug/Release) |
| `<leader>ms` | Stop CMake |
| `<leader>mo` | Open CMake output |
| `<leader>mc` | Close CMake output |

**Workflows supported:**
1. **Preset-based**: Just use `<leader>mp` to select preset, then `<leader>mg` to generate
2. **Traditional**: Use `<leader>mT` to select build type (Debug/Release)
3. **Custom/Manual**: Run your own cmake command, then `<leader>mD` to point to your build dir

**Note:** cmake-tools automatically creates a symlink to `compile_commands.json` in your project root, and clangd is configured to find it.

### Task Runner (overseer.nvim)

| Key | Action |
|-----|--------|
| `<leader>or` | Run task (picker for all build systems) |
| `<leader>oo` | Toggle task list |
| `<leader>ob` | Build |
| `<leader>oa` | Task action menu |
| `<leader>oq` | Quick action |
| `<leader>ol` | Restart last task |

**Supported:** Make, CMake, Cargo, npm, Go, Gradle, Meson, Ninja, and more.

**Custom templates included:**
- `ninja` - Direct ninja build (auto-detects build directory)
- `ninja (select target)` - Ninja with target and directory selection
- `conan install` - Install Conan dependencies
- `cmake conan workflow` - Full CMake+Conan workflow

### Terminal (toggleterm.nvim)

| Key | Action |
|-----|--------|
| `<C-\>` | Toggle terminal |
| `<leader>tf` | Open floating terminal |
| `<leader>tH` | Open horizontal terminal |
| `<leader>tv` | Open vertical terminal |

**In terminal mode:**
- `<Esc><Esc>` - Exit to normal mode
- `<C-\>` - Close terminal
- Use `i` to re-enter insert mode

### Debugging (nvim-dap)

| Key | Action |
|-----|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Set conditional breakpoint |
| `<leader>dc` | Continue execution |
| `<leader>di` | Step into |
| `<leader>do` | Step over |
| `<leader>dO` | Step out |
| `<leader>dr` | Toggle REPL |
| `<leader>dl` | Run last debug config |
| `<leader>dt` | Terminate debug session |
| `<leader>du` | Toggle debug UI |
| `<leader>de` | Evaluate expression (normal/visual) |

## 🎨 Colorscheme

**Kanagawa** with transparent background
- Dark theme inspired by famous painting "The Great Wave off Kanagawa"
- Custom ColorColumn highlighting (darker than CursorLine)

## 🛠️ LSP Servers Configured

- **clangd** - C/C++ (with extensive flags for tsi-logger project)
- **cmake** - CMake
- **ocaml_ls** - OCaml (installed via opam, not Mason)
- **lua_ls** - Lua
- **rust-analyzer** - Rust (via rustaceanvim)
- **pyright** - Python (type checking, IntelliSense)
- **ruff** - Python (fast linting)
- **harper_ls** - Grammar/spell checker (markdown, git commits, text)

### Harper (Grammar Checker)

Harper checks grammar and spelling in markdown, git commits, and text files.

**What it catches:**
- Spelling errors
- "A" vs "an" mistakes
- Sentence capitalization
- Unclosed quotes
- Long sentences (readability)
- Repeated words ("the the")
- Extra spaces
- Wrong number suffixes ("1th" → "1st")

**Usage:**
- Errors appear as diagnostics (underlined)
- `<leader>ca` - Code action to fix or add to dictionary
- `K` (hover) - Shows the grammar issue explanation

## 📝 Formatters

- **stylua** - Lua
- **clang-format** - C/C++
- **ruff** - Python (fast formatting and import sorting)
- **prettier/prettierd** - JavaScript
- **rustfmt** - Rust

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
- Ligatures disabled via `neovide_font_features`

### Line Numbers
- Absolute line numbers by default
- Relative line numbers automatically enabled in visual mode (for easy range selection)

## 🔧 Customization

To customize, edit files in `lua/config/` and `lua/plugins/`:

- **Options**: `lua/config/options.lua`
- **Keymaps**: `lua/config/keymaps.lua`
- **New plugin**: Create file in `lua/plugins/` (auto-loaded)
- **LSP servers**: Edit `lua/plugins/lsp.lua`

## 📋 Prerequisites

### Required

Install these before using this configuration:

```bash
# macOS (Homebrew)
brew install neovim git ripgrep fd lazygit
brew install --cask font-jetbrains-mono-nerd-font

# Linux (Ubuntu/Debian)
sudo apt install git ripgrep fd-find
# Neovim - use AppImage or build from source for latest version
# https://github.com/neovim/neovim/releases
# lazygit: https://github.com/jesseduffield/lazygit#installation

# Linux (Fedora/RHEL)
sudo dnf install neovim git ripgrep fd-find
# lazygit: https://github.com/jesseduffield/lazygit#installation

# Cross-platform (pixi - recommended for reproducible environments)
pixi global install neovim ripgrep fd lazygit

# Nerd Font (Linux) - download from https://www.nerdfonts.com/
# Extract to ~/.local/share/fonts/ and run: fc-cache -fv
```

| Dependency | Purpose |
|------------|---------|
| [Neovim](https://neovim.io/) ≥ 0.10 | Editor (0.11+ recommended) |
| [Git](https://git-scm.com/) | Plugin management, gitsigns, diffview |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | Telescope live grep |
| [fd](https://github.com/sharkdp/fd) | Telescope file finder |
| [lazygit](https://github.com/jesseduffield/lazygit) | Git TUI (`<leader>gg`) |
| [Nerd Font](https://www.nerdfonts.com/) | Icons in UI |

### Build Tools (for Treesitter)

```bash
# macOS
xcode-select --install
# or
brew install gcc make

# Linux (Ubuntu/Debian)
sudo apt install build-essential

# Linux (Fedora/RHEL)
sudo dnf groupinstall "Development Tools"

# pixi
pixi global install gcc make
```

### Optional (Language-Specific)

```bash
# C/C++ development
brew install llvm cmake ninja                    # macOS
sudo apt install clang cmake ninja-build         # Ubuntu/Debian
pixi global install clang cmake ninja            # pixi

# Rust development
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Python development
brew install python                              # macOS
sudo apt install python3 python3-pip python3-venv  # Ubuntu/Debian
pixi global install python                       # pixi
pip install debugpy                              # all platforms

# Node.js (for some LSP servers)
brew install node                                # macOS
sudo apt install nodejs npm                      # Ubuntu/Debian
pixi global install nodejs                       # pixi

# OCaml (if needed)
brew install opam                                # macOS
sudo apt install opam                            # Ubuntu/Debian
opam install ocaml-lsp-server                    # all platforms
```

### Installed Automatically via Mason

These tools are auto-installed by Mason on first launch:
- **LSP servers**: clangd, lua_ls, pyright, ruff, rust-analyzer, harper_ls
- **Formatters**: stylua, clang-format, prettier
- **Debug adapters**: debugpy, codelldb

Run `:Mason` to see/manage installed tools.

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

### CMake Commands (`<leader>m` prefix)
- `:CMakeGenerate` (`<leader>mg`) - Configure project (uses presets if available)
- `:CMakeBuild` (`<leader>mb`) - Build current target
- `:CMakeRun` (`<leader>mr`) - Run launch target
- `:CMakeSelectConfigurePreset` (`<leader>mp`) - Pick CMake preset
- `:CMakeSelectBuildTarget` (`<leader>mt`) - Pick build target

### Task Runner Commands
- `:OverseerRun` - Run a task (shows picker)
- `:OverseerToggle` - Show/hide task list
- `:OverseerRestartLast` - Re-run last task

### Terminal Commands
- `:ToggleTerm` - Toggle terminal
- `:TermExec cmd="your command"` - Run command in terminal

## 📚 Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [nvim-lspconfig Server Configurations](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)
- [Treesitter Playground](https://github.com/nvim-treesitter/playground)

## 🙏 Credits

Based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) with extensive modernization and customization.

---

**Last Updated**: February 2026

See [PERFORMANCE.md](PERFORMANCE.md) for detailed guide on handling large files (especially multi-GB log files).

**Quick Summary**:
- Files >2MB: Auto-disables LSP, treesitter, syntax
- Files >100MB: Additional optimizations (no line numbers, cursorline, etc.)
- Use `<leader>sg` (Telescope grep) for fast searching instead of `/`


## 🐛 Known Issues

### Stylua LSP Error
If you see "Client stylua quit with exit code 2" errors, this is harmless. Stylua is a formatter (used via conform.nvim), not an LSP server. The error occurs when Mason tries to auto-configure it as an LSP. Formatting still works correctly via `<leader>f`.

To silence these errors, the stylua LSP is disabled in the configuration.

### LSP and Lazygit/Diffview
LSP clients are automatically detached from diff/git/fugitive buffers to prevent
diagnostic noise when using `<leader>gg` (lazygit), `<leader>gd` (diffview), etc.
Terminal buffers also have diagnostics disabled automatically.

### Message Noise
noice.nvim is configured to suppress common noisy messages:
- "written" messages (file save confirmations)
- "search hit TOP/BOTTOM" wrapping indicators
- "No information available" from LSP hover on non-symbol locations
- "Already at oldest/newest change" undo boundary messages
- LSP client exit code notifications
- LSP progress is handled by fidget.nvim (noice LSP progress is disabled to avoid duplicates)
