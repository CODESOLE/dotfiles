vim.wo.wrap              = false
vim.o.showmode           = false
vim.o.swapfile           = false
vim.o.backup             = false
vim.o.writebackup        = false
vim.o.smartcase          = true
vim.o.ignorecase         = true
vim.o.smartindent        = true
vim.o.autoindent         = true
vim.o.expandtab          = true
vim.o.tabstop            = 2
vim.o.shiftwidth         = 2
vim.o.softtabstop        = 2
vim.o.showmatch          = true
vim.o.cmdheight          = 0
vim.o.signcolumn         = "no"
vim.g.mapleader          = ' '
vim.o.autocomplete       = true
vim.o.autocompletedelay  = 200
vim.o.complete           = ".,w,b,o"
vim.o.completeopt        = "menuone,noselect,fuzzy"
vim.keymap.set('n', 'gn', ':bn<CR>')
vim.keymap.set('n', 'gp', ':bp<CR>')
vim.keymap.set('n', 'go', ':lua vim.lsp.buf.workspace_symbol()<CR>')
vim.keymap.set('i', '<C-k>', '<Up>')
vim.keymap.set('i', '<C-j>', '<Down>')
vim.keymap.set('i', '<C-h>', '<Left>')
vim.keymap.set('i', '<C-l>', '<Right>')
vim.keymap.set('c', '<C-j>', '<Down>')
vim.keymap.set('c', '<C-k>', '<Up>')
vim.keymap.set('c', '<C-h>', '<Left>')
vim.keymap.set('c', '<C-l>', '<Right>')
vim.keymap.set('n', '<leader>l', ':cn<CR>', {silent = true, noremap = true})
vim.keymap.set('n', '<leader>h',  ':cp<CR>', {silent = true, noremap = true})
vim.keymap.set("n", "q", "<nop>", {})
vim.keymap.set({'n', 'v', 'i', 'c' }, 'ş', '<Esc>')
vim.keymap.set('t', 'ş', '<C-\\><C-N>')
vim.diagnostic.config({ virtual_text = true })
vim.cmd('au TextYankPost * silent! lua vim.hl.on_yank {higroup="IncSearch", timeout=500}')
vim.pack.add({"https://github.com/ingur/floatty.nvim", "https://github.com/bluz71/vim-moonfly-colors","https://github.com/neovim/nvim-lspconfig"})
vim.lsp.inlay_hint.enable(true)
vim.lsp.enable({'texlab', 'ols', 'clangd'})
vim.cmd.colorscheme("moonfly")
local term = require("floatty").setup{window = { width = 0.9, height = 0.9 }}
vim.keymap.set('n', '<C-t>', function() term.toggle() end)
vim.keymap.set('t', '<C-t>', function() term.toggle() end)
vim.api.nvim_set_hl(0, "@lsp.type.macro", {fg = '#e65e72'})
vim.api.nvim_set_hl(0, "@lsp.type.operator", {fg = '#ff0000'})
vim.api.nvim_set_hl(0, "@parameter", {fg = '#e3c78a'})
vim.api.nvim_set_hl(0, "@lsp.type.variable", {fg = '#725537'})
