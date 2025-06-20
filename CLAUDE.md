# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Neovim configuration based on **kickstart.nvim** - a single-file, educational starting point for Neovim configuration. This is NOT a distribution but a foundation for customization.

## Architecture

### Core Structure
- **Single-file approach**: Primary configuration lives in `init.lua` (1000+ lines)
- **Plugin management**: lazy.nvim handles all plugin installation and lazy loading
- **Modular extensions**: Optional plugins available in `lua/kickstart/plugins/`
- **Custom plugins**: User additions go in `lua/custom/plugins/`

### Key Components
- **LSP Stack**: nvim-lspconfig + mason.nvim for automatic LSP server management
- **Completion**: blink.cmp (modern completion engine) with LuaSnip for snippets
- **Fuzzy Finding**: Telescope with fzf-native for file/content search
- **Syntax**: Treesitter for highlighting and text objects
- **Formatting**: conform.nvim for code formatting
- **Git Integration**: gitsigns.nvim for git signs and hunks

## Common Commands

### Plugin Management
```bash
# View plugin status
:Lazy

# Update all plugins  
:Lazy update

# Install new plugins (after adding to config)
:Lazy install
```

### LSP and Development
```bash
# Check LSP server status
:Mason

# Check system health (includes dependency verification)
:checkhealth

# Check kickstart-specific health
:checkhealth kickstart

# Format current buffer
<leader>f

# LSP operations (when cursor on symbol)
grn         # Rename symbol
gra         # Code action
grr         # Find references  
grd         # Go to definition
gri         # Go to implementation
grt         # Go to type definition
```

### File Operations
```bash
# File finder
<leader>sf

# Live grep search
<leader>sg

# Recent files
<leader>s.

# Search current word
<leader>sw

# Buffer list
<leader><leader>

# File tree (if neo-tree enabled)
\
```

## Configuration Patterns

### Adding New Plugins
1. Edit `init.lua` and add plugin spec to the `require('lazy').setup({})` table
2. Or create file in `lua/custom/plugins/` that returns plugin spec
3. Restart Neovim - lazy.nvim will auto-install

### LSP Server Configuration
- Add server name to `servers` table in init.lua:712-703
- Mason will automatically install and configure
- Override server settings in the servers table

### Keybinding Conventions
- **Leader key**: `<space>`
- **Search operations**: `<leader>s*` (sh=help, sf=files, sg=grep, etc.)
- **Toggle operations**: `<leader>t*` (th=inlay hints, etc.)
- **Git operations**: `<leader>h*` (git hunks)
- **LSP operations**: `gr*` prefix (grn=rename, grd=definition, etc.)

## Dependencies

### Required External Tools
- `git`, `make`, `unzip`, C compiler
- `ripgrep` (rg) - for telescope live_grep
- `fd-find` (fd) - for telescope file finding  
- Clipboard tool (xclip/xsel/win32yank)

### Optional Tools
- Nerd Font for icons (set `vim.g.have_nerd_font = true` in init.lua)
- Language-specific tools (npm for TypeScript, go for Golang, etc.)

## Customization Philosophy

Kickstart encourages:
1. **Understanding**: Read and understand every line in init.lua
2. **Incremental changes**: Start small, add features as needed
3. **Documentation**: Well-commented configuration
4. **Modularity**: Break into separate files when configuration grows

### Custom Plugin Location
Place custom plugins in `lua/custom/plugins/*.lua` - each file should return a plugin spec or table of specs.

## Troubleshooting

### Common Issues
- Plugin not loading: Check `:Lazy` for errors
- LSP not working: Check `:Mason` for server installation
- Dependencies missing: Run `:checkhealth` for system verification
- Telescope issues: Ensure ripgrep and fd are installed

### Reset/Cleanup
```bash
# Remove plugin data (forces reinstall)
rm -rf ~/.local/share/nvim/

# Remove configuration cache
rm -rf ~/.local/state/nvim/
```

## Development Workflow

1. **Edit config**: Modify `init.lua` or add files to `lua/custom/plugins/`
2. **Reload**: Restart Neovim or use `:source %` for init.lua changes
3. **Install/Update**: Use `:Lazy` interface for plugin management
4. **Verify**: Run `:checkhealth` to ensure everything is working
5. **Backup**: Consider version controlling your configuration

The configuration prioritizes educational value and transparency over convenience - every feature should be understood by the user.

## Keybinding Guidelines
- Put custom keybindings in @local.lua unless they are scoped to a plugin