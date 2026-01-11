# Large File Performance Guide

## Your File Analysis

**File**: `20220928_125715_processDividends_EAST.log.SB1SYB4_DS.clientmlp.eod_mi2.20220929.out.its`
- **Size**: 1.4 GB (1,400 MB)
- **Lines**: 12,611,128 lines
- **Type**: ITS log file

This is an **extremely large** file that requires special handling.

## Optimizations Applied

### 1. Bigfile.nvim Configuration
- **Threshold**: 2MB (files larger trigger optimizations)
- **Patterns**: `*.log`, `*.out.its`, `out.its.*`
- **Disabled features for files >2MB**:
  - LSP
  - Treesitter
  - Syntax highlighting
  - Indent blankline
  - Matchparen
  - Illuminate

### 2. Extreme Optimizations (>100MB files)
When opening files larger than 100MB, additional features are disabled:
- Line numbers (`number`, `relativenumber`)
- Cursorline highlighting
- Folding
- Whitespace markers (`list`)
- Sign column
- Word wrap

**Result**: You'll get a notification showing file size and disabled features.

## Performance Tips for Your 1.4GB File

### ✅ Fast Operations

#### 1. **Use Telescope for Search** (Fastest)
```
<leader>sg    " Live grep (uses ripgrep - VERY fast)
```
Ripgrep can search your 1.4GB file in seconds vs minutes with Vim search.

#### 2. **Navigate by Line Number**
```
:12345678     " Jump to specific line instantly
gg            " Go to top
G             " Go to bottom
1234567gg     " Jump to line 1234567
```

#### 3. **Use Marks for Bookmarks**
```
ma            " Set mark 'a' at current position
'a            " Jump to mark 'a'
```

#### 4. **Fast Scrolling**
```
<C-d>         " Scroll down half page
<C-u>         " Scroll up half page
10<C-d>       " Scroll down 10 half pages
```

### ⚠️ Slow Operations (Avoid or Use Carefully)

#### 1. **Vim Search** (Slow on huge files)
```
/pattern      " Forward search - can be SLOW
?pattern      " Backward search - can be SLOW
```
**Alternative**: Use Telescope's live grep (`<leader>sg`) instead!

#### 2. **Substitutions** (Very Slow)
```
:%s/old/new/g " Replace all - VERY SLOW on 12M lines
```
**Alternative**: Use `sed` or `awk` from command line if you need to modify.

#### 3. **Visual Block on Many Lines** (Slow)
```
<C-v>jjjj...  " Visual block over thousands of lines
```

## Recommended Workflow for 1.4GB Files

### Option 1: Quick View/Search (In Neovim)
```bash
# Open normally - bigfile optimizations kick in
nvim huge_file.log

# Use Telescope to search
<leader>sg    # Search for text
```

### Option 2: Read-Only Viewing (Fastest)
```bash
# Use less (very fast, optimized for huge files)
less huge_file.log

# Or use bat (syntax highlighting, slower but prettier)
bat huge_file.log

# Or use tail to see recent lines
tail -f -n 1000 huge_file.log
```

### Option 3: Extract Sections
```bash
# Extract specific lines to smaller file
sed -n '1000000,2000000p' huge_file.log > section.log
nvim section.log  # Much faster!

# Or grep relevant sections
grep "ERROR" huge_file.log > errors.log
nvim errors.log
```

### Option 4: Use Telescope from Command Line
```bash
# Open directory, then use Telescope to search
nvim /Users/vladimir/Downloads/its-logs-2025/

# Then in Neovim:
<leader>sg    # Search all files in directory
```

## Performance Comparison

| Operation | Small File (1MB) | Your File (1.4GB) |
|-----------|------------------|-------------------|
| Open file | Instant | 2-5 seconds |
| Scroll (Ctrl-d) | Instant | Instant ✓ |
| Jump to line | Instant | Instant ✓ |
| Telescope search | Instant | 5-10 seconds ✓ |
| Vim search `/` | Instant | 30-120 seconds ✗ |
| Substitution `:%s` | Instant | Several minutes ✗ |
| Syntax highlighting | Enabled | Disabled (for speed) |

## Advanced: Command-Line Tools for Log Analysis

For files this large, consider specialized tools:

```bash
# Fast grep
rg "pattern" huge_file.log

# Count occurrences
grep -c "ERROR" huge_file.log

# Get line numbers of matches
grep -n "pattern" huge_file.log

# Extract time range (if timestamps are consistent)
awk '/09\/29\/2022 02:00/,/09\/29\/2022 03:00/' huge_file.log

# Split into smaller files
split -l 1000000 huge_file.log chunk_  # 1M lines per file
```

## Summary

**For your 1.4GB file:**
- ✅ **Opening**: Works, takes 2-5 seconds
- ✅ **Scrolling**: Fast with Ctrl-d/Ctrl-u
- ✅ **Search**: Use `<leader>sg` (Telescope) - fast!
- ✅ **Line jumps**: `:line_number` - instant
- ⚠️ **Vim search**: Avoid `/` - use Telescope instead
- ❌ **Editing**: Not recommended - use sed/awk for modifications
- 🎯 **Best practice**: Extract relevant sections with grep/sed first

The configuration is now optimized to handle your massive log files efficiently!
