# Configuration audit — September 2026

This configuration targets Neovim **0.11.5** (including the local performance build). The audit repaired API mismatches and conflicting integrations rather than replacing the plugin stack wholesale. Start a new Neovim process after updating; existing sessions retain their loaded Lua modules and parsers.

## Fixes and refactoring

| Area | Finding | Change |
| --- | --- | --- |
| Treesitter | `require('nvim-treesitter').setup(opts)` on the installed compatibility branch ignores those options. | Use `nvim-treesitter.configs.setup`, explicitly enable highlighting, pin `master`, and install parsers in the standard data/site directory. |
| Python syntax | An existing parser/query mismatch failed on the `except*` node. | Rebuild parsers for the pinned plugin version with `:TSUpdateSync`. |
| LSP / Mason | Mason v2 ignores the old `handlers` setup. Intended capabilities and server settings were not applied. | Configure through `vim.lsp.config`, then enable only the intended servers. Preserve system-tool support and clangd compilation-database discovery. |
| Diff errors | clangd logs showed requests with unsupported non-file URIs. Detaching based on panel filetypes misses revision buffers carrying `cpp` filetype. | Reject special/URI/large buffers before LSP activation through the root callback. Real working files in diff windows keep LSP support. |
| Git navigation | File-history command expanded `%` textually; commit selection assumed an entry always existed. | Structured command arguments, empty-selection guard, and repository roots based on the current file. Tested file history with spaces. |
| Large files | One huge-file hook globally disabled syntax and filetype detection. | Restrict suppression to the affected buffer; keep manual folding and early persistent-undo exclusion. Share the large-buffer predicate with the statusline and parsing guards. |
| Folding | Expression folding was the global default, including non-code buffers. | Default to manual folds; enable Treesitter folds in supported ordinary code buffers. Leave diff-mode folding to the diff tool. |
| Startup | Deferred `require()` calls forced plugins to load; an extra `rshada` repeated work without disabling the normal read. | Remove the misleading performance module. Load Neorg only for its files/commands/keys. Disable Snacks quickfile's separate unguarded highlighter path. |
| UI | Dressing, Telescope UI-select and Snacks input overlapped; Snacks and Noice/notify competed for notifications. | Telescope handles selection, Snacks handles text input, Noice plus nvim-notify handle messages. Remove Dressing. |
| References | Snacks words and LSP autocmds both highlighted references. | Keep the LSP handlers and avoid duplicate buffer autocmds. Scope inlay-hint toggling to the current buffer. |
| Python debugger | `Package:get_install_path()` was removed in Mason v2. | Resolve the debugpy venv under Mason's data directory. |
| Python environments | Old `regexp` branch/options emitted migration warnings; `fd` was missing locally. | Move venv-selector to `main`, use current options and Telescope, preserve manual cached-env activation. Install `fd` locally. |
| Rust | Duplicate plugin spec, hardcoded `lldb-vscode`, and global repeated insertion of the crates completion source. | Merge the spec, configure before plugin startup, use debugger discovery, and make crates completion buffer-local. |
| CMake | Global compiler flags were overwritten with a mixture of GCC/Clang color flags. | Keep `CMAKE_COLOR_DIAGNOSTICS=OFF` and preserve project compiler flags. |
| Key conflict | Harpoon previous-file and Git preview both used Space-h-p. | Git preview keeps Space-h-p; Harpoon previous-file moves to Space-h-Shift-P. |
| Reproducibility | `lazy-lock.json` was ignored by Git. | Track tested revisions. Package updates become reviewable diffs. |

The old broad Noice filter hiding any notification containing “exit code” was removed so genuine failures remain visible. This does not mean every historical lazygit/diff issue has been reproduced; the concrete clangd URI failure and current opening workflows were checked.

## Markdown reading

The existing render-markdown plugin remains; a new renderer was unnecessary. Normal/command mode uses stable rendering, wrapped prose with word boundaries, compact heading/code backgrounds, rounded tables, and less gutter clutter. Insert mode reveals source. Space-t-m toggles rendering. Code windows retain their usual settings. Harper's inline diagnostic text is suppressed while its signs, floats, and code actions remain available.

This is in-editor rendering, not a browser layout engine. Extremely wide tables may still require horizontal space, and fonts/terminal contrast affect appearance. No browser preview service was installed.

## Package manager and Treesitter choices

Keep **lazy.nvim** for now: the configuration uses its dependency resolution, lazy events, key handlers, and lockfile. A move to native `vim.pack` would be a separate configuration migration and would change the supported Neovim baseline. The installed 0.11.5 binary does not expose `vim.pack`. The [native package documentation](https://neovim.io/doc/user/pack/) describes the alternative; [lazy.nvim](https://github.com/folke/lazy.nvim) remains the manager used here.

Neovim already provides Treesitter parsing/highlighting/folding APIs. nvim-treesitter still supplies parser management and language queries; those are not redundant. Its current `main` branch is an incompatible rewrite requiring Neovim 0.12; `master` is the compatibility branch for 0.11. Upgrade Neovim and migrate that setup together, including dependent plugins and parser rebuilds. [Treesitter requirements](https://github.com/nvim-treesitter/nvim-treesitter#requirements)

Mason manages external language servers and tools, not Lua plugins. Its v2 integration uses Neovim's native LSP configuration API. [Mason integration](https://github.com/mason-org/mason-lspconfig.nvim#introduction), [nvim-lspconfig migration](https://github.com/neovim/nvim-lspconfig#quickstart)

Targeted plugin revisions were refreshed for render-markdown, Snacks, venv-selector, and the Treesitter compatibility branch. Diffview was already at its upstream main revision. Other plugins retain their existing tested revisions; Rust's major version is retained. No editor binary or entire plugin catalog was upgraded.

## Validation and remaining limits

The isolated terminal checks exercised actual Markdown parsers/decorations and source toggle, a filename containing spaces in Diffview history, C++ LSP attachment, three Diffview URI buffers without LSP clients, Python plugin/debugger setup, large-buffer completion/count/fold/LSP guards, restoration on a small buffer, and Space-s-g/Space-s-w mappings. Lazygit 0.58.1 launched in a terminal buffer without attached LSP clients. Its normal opening was checked; arbitrary historical error paths were not all reproducible.

These checks do not prove every language server, Rust debugging session, project-specific CMake build, Jira integration, or Python environment works. Those depend on project/tool setup. Existing project preferences, editor bindings, the C-as-C++ parser mapping, and the no-swap preference are retained. Persistent undo is edit history, not a substitute for recovering unsaved changes after a crash.

To inspect future problems, use `:messages`, `:Noice history`, `:checkhealth`, `:LspInfo`, and `:ConformInfo`. Review `:Lazy` updates deliberately; after Treesitter updates, run `:TSUpdate`. Use `:Lazy restore` to restore plugin revisions from the checked-in lockfile. Parser binaries are local build artifacts and need rebuilding separately.
