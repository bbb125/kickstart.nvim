# Neovim Key Mappings &amp; Plugins Cheat Sheet\n\n## Major Plugins Used\n\n- **Telescope.nvim**: Fuzzy finder (files, grep, git, buffers)\n- **nvim-lspconfig + mason.nvim**: LSP for code completion, diagnostics, refactoring\n- **nvim-treesitter**: Advanced syntax highlighting, indentation\n- **gitsigns.nvim**: Git gutter signs, hunk preview/navigation\n- **trouble.nvim**: Diagnostics, LSP references list\n- **conform.nvim**: Auto-formatting\n- **oil.nvim**: File explorer (Netrw alternative)\n- **Comment.nvim**: Fast commenting\n- **which-key.nvim**: Leader key hints popup\n- **neo-tree.nvim**: Alternative file explorer\n- **nvim-autopairs**: Auto close pairs\n- **indent-blankline.nvim**: Indent guides\n- **nvim-lint**: Linter integration\n\n## Key Mappings\n\n### Leader Key (SPACE)\n\n| Key | Action |\n|----|--------|\n| `<leader>e` | Toggle Oil file explorer |\n| `<leader>vw` | Toggle line numbers |\n| `<leader>sw` | Toggle relative line numbers |\n| `<leader>u` | Open undo tree |\n| `<leader>l` | Toggle diagnostics |\n| `<leader>fm` | Format current file (conform.nvim) |\n\n### Telescope Fuzzy Finder\n\n| Key | Action |\n|----|--------|\n| `<leader>ff` | Find files |\n| `<leader>fs` | Live grep in files |\n| `<leader>fc` | Grep current word/string |\n| `<leader>fb` | Switch buffers |\n| `<leader>fh` | Help tags |\n| `<leader>gf` | Git files |\n| `<leader>sc` | Git commits |\n| `<leader>sb` | Git branches |\n| `<leader>?` | Recently opened files |\n\n### LSP (Normal mode)\n\n| Key | Action |\n|----|--------|\n| `gd` | Goto definition |\n| `K` | Hover documentation |\n| `<leader>vws` | Workspace symbols |\n| `<leader>vca` | Code actions |\n| `<leader>vrr` | Rename symbol |\n| `<leader>vrn` | Rename file &amp; update imports |\n| `<leader>D` | Type definition |\n| `<leader>uR` | LSP references |\n\n### Git (Gitsigns.nvim)\n\n| Key | Action |\n|----|--------|\n| `]c` | Next hunk |\n| `[c` | Previous hunk |\n| `<leader>ph` | Preview hunk |\n| `<leader>gb` | Blame current line |\n\n### Comments (Comment.nvim)\n\n| Key | Action |\n|----|--------|\n| `gcc` | Toggle comment current line |\n| `gbc` | Toggle block comment |\n\n### Window/Split Management\n\n| Key | Action |\n|----|--------|\n| `<C-h/j/k/l>` | Resize splits |\n\n### Visual Mode\n\n| Key | Action |\n|----|--------|\n| `J` | Selection join (no added space) |\n| `K` | Keep cursor middle after move |\n| `&lt;` | Decrease indent |\n| `&gt;` | Increase indent |\n\n### Other\n\n| Key | Action |\n|----|--------|\n| `&lt;C-d&gt;` | Scroll down half page |\n| `&lt;C-u&gt;` | Scroll up half page |\n\n**Note**: Leader is SPACE. Check `:verbose map <leader>` or which-key popup for full/updates.


# Neovim Key Mappings & Plugins Cheat Sheet

## Major Plugins Used

- **Telescope.nvim**: Fuzzy finder (files, grep, git, buffers)
- **nvim-lspconfig + mason.nvim**: LSP for code completion, diagnostics, refactoring
- **nvim-treesitter**: Advanced syntax highlighting, indentation
- **gitsigns.nvim**: Git gutter signs, hunk preview/navigation
- **trouble.nvim**: Diagnostics, LSP references list
- **conform.nvim**: Auto-formatting
- **oil.nvim**: File explorer (Netrw alternative)
- **Comment.nvim**: Fast commenting
- **which-key.nvim**: Leader key hints popup
- **neo-tree.nvim**: Alternative file explorer
- **nvim-autopairs**: Auto close pairs
- **indent-blankline.nvim**: Indent guides
- **nvim-lint**: Linter integration

## Key Mappings

### Leader Key (SPACE)

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle Oil file explorer |
| `<leader>vw` | Toggle line numbers |
| `<leader>sw` | Toggle relative line numbers |
| `<leader>u` | Open undo tree |
| `<leader>l` | Toggle diagnostics |
| `<leader>fm` | Format current file (conform.nvim) |

### Telescope Fuzzy Finder

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fs` | Live grep in files |
| `<leader>fc` | Grep current word/string |
| `<leader>fb` | Switch buffers |
| `<leader>fh` | Help tags |
| `<leader>gf` | Git files |
| `<leader>sc` | Git commits |
| `<leader>sb` | Git branches |
| `<leader>?` | Recently opened files |

### LSP (Normal mode)

| Key | Action |
|-----|--------|
| `gd` | Goto definition |
| `K` | Hover documentation |
| `<leader>vws` | Workspace symbols |
| `<leader>vca` | Code actions |
| `<leader>vrr` | Rename symbol |
| `<leader>vrn` | Rename file & update imports |
| `<leader>D` | Type definition |
| `<leader>uR` | LSP references |

### Git (Gitsigns.nvim)

| Key | Action |
|-----|--------|
| `]c` | Next hunk |
| `[c` | Previous hunk |
| `<leader>ph` | Preview hunk |
| `<leader>gb` | Blame current line |

### Comments (Comment.nvim)

| Key | Action |
|-----|--------|
| `gcc` | Toggle comment current line |
| `gbc` | Toggle block comment |

### Window/Split Management

| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Resize splits |

### Visual Mode

| Key | Action |
|-----|--------|
| `J` | Selection join (no added space) |
| `K` | Keep cursor middle after move |
| `<` | Decrease indent |
| `>` | Increase indent |

### Other

| Key | Action |
|-----|--------|
| `<C-d>` | Scroll down half page |
| `<C-u>` | Scroll up half page |

---

**Note**: Leader is SPACE. Check `:verbose map <leader>` or which-key popup for full mappings and updates.
