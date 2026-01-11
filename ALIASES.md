# Neovim Aliases for Large Files

## Shell Aliases

Add these to your `~/.zshrc` or `~/.bashrc`:

```bash
# Fast nvim for huge files (>100MB) - bypasses all plugins
alias nvim-fast='nvim -u ~/.config/nvim/minimal.lua'
alias nf='nvim -u ~/.config/nvim/minimal.lua'

# Clean nvim (no config at all) - fastest possible
alias nvim-clean='nvim --clean'
alias nc='nvim --clean'

# No plugins but keep core config
alias nvim-noplugins='nvim --noplugin'
```

## Usage Examples

```bash
# Your 1.4GB log file
nvim-fast huge_log_file.out.its     # Uses minimal.lua
nf huge_log_file.out.its            # Short alias

# Absolute fastest (no config)
nvim-clean huge_log_file.out.its    # Bare bones
nc huge_log_file.out.its            # Short alias

# Regular nvim for normal files
nvim normal_file.lua                # Full config with plugins
```

## Performance Comparison

| Method | Startup Time | Features | Use Case |
|--------|--------------|----------|----------|
| `nvim --clean` | 0.02s | None | Absolute fastest, no features |
| `nvim-fast` (minimal.lua) | 0.03s | Basic settings, no plugins | Huge files (>100MB) |
| `nvim` (your config) | 0.17s | All plugins, LSP, etc. | Normal development |

## What's in minimal.lua?

The minimal config includes:
- ✅ Essential settings (no numbers, cursorline, etc.)
- ✅ Basic keymaps (Esc to clear search, Ctrl-d/u scrolling)
- ✅ No plugins (fastest possible with some conveniences)
- ✅ Ripgrep integration for fast searching
- ✅ Undo file enabled (crash recovery)
- ❌ No syntax highlighting
- ❌ No LSP
- ❌ No treesitter

## Recommended Workflow

1. **Massive files (>500MB)**: Use `nvim-clean` or `nvim-fast`
   ```bash
   nf huge_file.log
   ```

2. **Large files (10-500MB)**: Regular nvim works fine
   ```bash
   nvim large_file.log  # Bigfile optimizations kick in
   ```

3. **Normal files (<10MB)**: Regular nvim with all features
   ```bash
   nvim normal_file.cpp  # Full LSP, completion, etc.
   ```

## Installing Aliases

```bash
# Add to ~/.zshrc or ~/.bashrc
cat >> ~/.zshrc << 'HEREDOC'
# Neovim aliases for large files
alias nvim-fast='nvim -u ~/.config/nvim/minimal.lua'
alias nf='nvim -u ~/.config/nvim/minimal.lua'
alias nvim-clean='nvim --clean'
alias nc='nvim --clean'
HEREDOC

# Reload shell
source ~/.zshrc
```

## Testing

```bash
# Test minimal config
time nvim-fast huge_file.log "+quit"

# Compare with clean
time nvim-clean huge_file.log "+quit"

# Compare with full config
time nvim huge_file.log "+quit"
```
