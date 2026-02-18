# Neovim Configuration

Opinionated Neovim setup focused on modern LSP, fast navigation, and sensible defaults.

## Features
- Plugin management with lazy.nvim
- LSP support with Mason + nvim-lspconfig
- Autocomplete with nvim-cmp + LuaSnip
- Treesitter syntax highlighting and indentation
- Telescope fuzzy finder + ui-select integration
- Neo-tree file explorer
- Git integrations via gitsigns and LazyGit
- Formatting and diagnostics with none-ls (prettier, black, isort, stylua, eslint_d, tflint, codespell)
- JavaScript/TypeScript debugging with nvim-dap + dap-ui
- Lualine statusline
- Catppuccin colorscheme

## Prerequisites
- Neovim (latest stable recommended)
- Git
- Node.js + npm (for JS debugging and some tools)

## Setup
1. Backup any existing config:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   ```
2. Clone this repo:
   ```bash
   git clone <your-repo-url> ~/.config/nvim
   ```
3. Start Neovim:
   ```bash
   nvim
   ```
   lazy.nvim will install plugins automatically.
4. Install LSPs and tools (optional but recommended):
   ```vim
   :Mason
   ```

## Key Bindings (selection)
- Leader key: `Space`
- Telescope: `Space` + `ff` (files), `fg` (live grep), `fb` (buffers), `fh` (help)
- Neo-tree: `Space` + `no` (open), `nc` (close)
- LSP: `gd` (definition), `gD` (declaration), `gR` (references), `K` (hover), `Space` + `rn` (rename)
- Diagnostics: `Space` + `d` (line), `Space` + `D` (buffer), `[d` / `]d` (prev/next)
- Format: `Space` + `gf`
- Git: `Space` + `lg` (LazyGit), `]h` / `[h` (next/prev hunk)
- Debug: `Space` + `dt` (toggle breakpoint), `Space` + `dc` (continue)

## Notes
- Tabs are set to 2 spaces, line numbers enabled.
- To customize, update files in `lua/config` and `lua/plugins`.
