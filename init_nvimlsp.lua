vim.cmd("set termguicolors")
require "paq" {
  "savq/paq-nvim",
  "ggandor/leap.nvim",
  "puremourning/vimspector",
  "neovim/nvim-lspconfig",
}
vim.opt.wildignore:append{'*/builddir/*', '*/build/*', 'tags', 'node_modules/*', '.git/*', '.cache/*', '.clangd/*', 'target/*'}
vim.o.showmode     = false
vim.o.swapfile     = false
vim.o.backup     = false
vim.o.writebackup = false
vim.o.smartcase    = true
vim.o.ignorecase   = true
vim.o.smartindent  = true
vim.o.autoindent   = true
vim.o.showmatch    = true
vim.o.hidden       = true
vim.g.mapleader    = ' '
vim.o.cmdheight = 0
vim.o.signcolumn = "no"
vim.o.path="**"
vim.cmd('au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=500}')
vim.cmd('colorscheme habamax')
require('leap').create_default_mappings()
require('lspconfig').clangd.setup{}
require('lspconfig').rust_analyzer.setup{}
vim.keymap.set('n', '<leader><leader>', ':nohlsearch<CR>')
vim.keymap.set('n', 'gl', '$')
vim.keymap.set('n', 'gh', '0')
vim.keymap.set('n', 'gn', ':bn<CR>')
vim.keymap.set('n', 'gp', ':bp<CR>')
vim.keymap.set('i', '<C-k>', '<Up>')
vim.keymap.set('i', '<C-j>', '<Down>')
vim.keymap.set('i', '<C-h>', '<Left>')
vim.keymap.set('i', '<C-l>', '<Right>')
vim.keymap.set('c', '<C-j>', '<Down>')
vim.keymap.set('c', '<C-k>', '<Up>')
vim.keymap.set('c', '<C-h>', '<Left>')
vim.keymap.set('c', '<C-l>', '<Right>')
vim.keymap.set('t', '<Esc>', '<C-\\><C-N>')
vim.keymap.set('n', '<leader>H', '<C-w>t<C-w>H', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>K', '<C-w>t<C-w>K', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>l', ':cn<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>h', ':cp<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>O', ':ccl<cr>', { noremap = true, silent = true })
vim.cmd 'nnoremap <Leader>dr <Plug>VimspectorRestart'
vim.cmd 'nnoremap <Leader>de <Plug>VimspectorStop'
vim.cmd 'nnoremap <Leader>dc <Plug>VimspectorContinue'
vim.cmd 'nnoremap <Leader>dt <Plug>VimspectorRunToCursor'
vim.cmd 'nnoremap <Leader>db :call vimspector#ToggleBreakpoint()<CR>'
vim.cmd 'nnoremap <Leader>dl <Plug>VimspectorToggleConditionalBreakpoint'
vim.cmd 'nnoremap <Leader><Up> <Plug>VimspectorUpFrame'
vim.cmd 'nnoremap <Leader><Down> <Plug>VimspectorDownFrame'
vim.cmd 'nnoremap <Leader>dh <Plug>VimspectorStepOut'
vim.cmd 'nnoremap <Leader>dk <Plug>VimspectorStepInto'
vim.cmd 'nnoremap <Leader>dj <Plug>VimspectorStepOver'
vim.cmd 'nnoremap <Leader>dp <Plug>VimspectorBalloonEval'
vim.cmd 'vnoremap <Leader>dp <Plug>VimspectorBalloonEval'
vim.cmd 'nnoremap <Leader>B <Plug>VimspectorBreakpoints'
vim.keymap.set("n", "q", "<nop>", {})
