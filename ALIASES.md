# Neovim Aliases for Large Files

## Understanding `nvim -u`

The `-u` flag tells nvim to use a **specific config file** instead of your normal `~/.config/nvim/init.lua`.

```bash
nvim -u ~/.config/nvim/minimal.lua huge_file.log
```

**Problems with `-u`:**
- Can cause errors if the minimal config has issues
- Requires maintaining a separate config file
- Less intuitive than other methods

## 🎯 RECOMMENDED: Use `--clean` Instead

**Simplest and fastest** - no config at all:

```bash
# Just use --clean (0.02s startup)
nvim --clean huge_file.log

# Add a short alias
alias nv='nvim --clean'
nv huge_file.log
```

**Pros:**
- ✅ Fastest possible (0.02s)
- ✅ No errors (nothing to break)
- ✅ No maintenance needed
- ✅ Works everywhere

**Cons:**
- ❌ No clipboard support
- ❌ No custom keymaps
- ❌ Bare bones experience

## Alternative: Quick Settings Function

Add this to your `~/.zshrc`:

```bash
# Function for large files
nf() {
    nvim -c "set noswapfile noundofile nobackup nowritebackup" \
         -c "set number! signcolumn=no cursorline!" \
         -c "syntax off" \
         "$@"
}
```

Usage:
```bash
nf huge_file.log  # Opens with minimal settings
```

## Comparison

| Method | Startup | Errors | Clipboard | Custom Keys | Maintenance |
|--------|---------|--------|-----------|-------------|-------------|
| `nvim --clean` | 0.02s | ✅ None | ❌ No | ❌ No | ✅ None |
| `nvim -u minimal.lua` | 0.03s | ⚠️ Possible | ✅ Yes | ✅ Basic | ⚠️ File to maintain |
| `nf()` function | 0.05s | ✅ None | ✅ Yes | ❌ No | ✅ None |
| `nvim` (full) | 0.17s | ✅ None | ✅ Yes | ✅ All | ✅ Your config |

## 🏆 Recommended Setup

Add these to your `~/.zshrc`:

```bash
# Fastest - use for gigabyte files
alias nv='nvim --clean'

# Fast with basic features
nf() {
    nvim -c "set nonu nornu nocul signcolumn=no" \
         -c "set noswapfile noundofile" \
         -c "syntax off" \
         "$@"
}

# Show file size and suggest fast mode
alias nvim-check='du -h'
```

Reload:
```bash
source ~/.zshrc
```

Usage:
```bash
# Check file size first
nvim-check huge_file.log

# If it's huge, use fast mode
nv huge_file.log      # Absolutely fastest (no frills)
# or
nf huge_file.log      # Fast with some settings

# Normal files
nvim normal_file.cpp  # Full config with LSP, etc.
```

## Your 1.4GB File

**Best approach:**

```bash
# For viewing/searching only
less huge_file.log                    # Fastest viewer
# or
bat huge_file.log                     # With syntax highlighting

# For editing
nvim --clean huge_file.log            # 0.02s startup
# or just:
nv huge_file.log                      # If you add the alias

# For searching
rg "pattern" huge_file.log            # Much faster than Vim search
```

## Quick Reference

```bash
# Add these three aliases to ~/.zshrc:
alias nv='nvim --clean'                      # Fastest
alias nvim-check='du -h'                     # Check size
nf() { nvim -c "set nonu nocul" -c "syntax off" "$@"; }  # Fast + basic
```

**Then:**
- Files >500MB: Use `nv` (--clean)
- Files 10-500MB: Use `nvim` (your config auto-optimizes)
- Files <10MB: Use `nvim` (full features)
