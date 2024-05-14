require 'paq' {
  "savq/paq-nvim",
  "bluz71/vim-moonfly-colors",
  "tpope/vim-sleuth",
  "kylechui/nvim-surround",
  "ggandor/leap.nvim",
  "echasnovski/mini.pairs",
  "echasnovski/mini.completion",
  "neovim/nvim-lspconfig",
  "puremourning/vimspector",
  "nvim-lualine/lualine.nvim",
  "ibhagwan/fzf-lua",
}
vim.cmd("set termguicolors")
vim.g.moonflyWinSeparator = 2
vim.g.moonflyVirtualTextColor = true
vim.o.showmode     = false
vim.o.swapfile     = false
vim.o.backup     = false
vim.o.writebackup = false
vim.o.smartcase    = true
vim.o.ignorecase   = true
vim.o.smartindent  = true
vim.o.autoindent   = true
vim.o.showmatch    = true
vim.o.cmdheight    = 0
vim.o.signcolumn   = "no"
vim.g.mapleader    = ' '
vim.cmd('au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=500}')
vim.cmd('colorscheme moonfly')
require('lualine').setup { options = { icons_enabled = false, section_separators = '', component_separators = '' }, sections = {
  lualine_a = { 'branch' },
  lualine_b = { { 'filename', path = 1 } },
  lualine_c = { 'diff', 'filesize' },
  lualine_x = { 'selectioncount', 'diagnostics', 'progress' },
  lualine_y = { 'location' },
  lualine_z = { 'searchcount' },
} }
require('leap').create_default_mappings()
require('mini.pairs').setup()
require('mini.completion').setup()
require('nvim-surround').setup()
require('lspconfig').clangd.setup{}
require('lspconfig').rust_analyzer.setup{}
require('fzf-lua').setup{'fzf-native'}
vim.keymap.set("n", "<leader>ff", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
vim.keymap.set("n", "<leader>fl", "<cmd>lua require('fzf-lua').live_grep()<CR>", { silent = true })
vim.keymap.set("n", "<leader>fg", "<cmd>lua require('fzf-lua').git_files()<CR>", { silent = true })
vim.keymap.set("n", "<leader>fb", "<cmd>lua require('fzf-lua').buffers()<CR>", { silent = true })
vim.keymap.set("n", "<leader>fs", "<cmd>lua require('fzf-lua').lsp_document_symbols()<CR>", { silent = true })
vim.keymap.set("n", "<leader>fw", "<cmd>lua require('fzf-lua').lsp_live_workspace_symbols()<CR>", { silent = true })
vim.keymap.set("n", "<leader>fr", "<cmd>lua require('fzf-lua').lsp_references()<CR>", { silent = true })
vim.keymap.set("n", "<leader>fa", "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>", { silent = true })
vim.keymap.set("n", "<leader>fd", "<cmd>lua require('fzf-lua').diagnostics_document()<CR>", { silent = true })
vim.keymap.set("n", "<leader>fD", "<cmd>lua require('fzf-lua').diagnostics_workspace()<CR>", { silent = true })
vim.keymap.set("n", "<leader>fo", "<cmd>lua require('fzf-lua').oldfiles()<CR>", { silent = true })
vim.keymap.set("n", "<leader>fc", "<cmd>lua require('fzf-lua').lgrep_curbuf()<CR>", { silent = true })
vim.lsp.inlay_hint.enable(true)
vim.keymap.set('n', '<leader>t', ':sp | term<CR>')
vim.keymap.set('n', '<leader>g', ':!lazygit<CR>')
vim.keymap.set('n', '<leader><CR>', ':nohlsearch<CR>')
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
vim.keymap.set('n', '<A-j>', '<C-w>j')
vim.keymap.set('n', '<A-k>', '<C-w>k')
vim.keymap.set('n', '<A-h>', '<C-w>h')
vim.keymap.set('n', '<A-l>', '<C-w>l')
vim.keymap.set('i', '<A-j>', '<C-\\><C-N><C-w>j')
vim.keymap.set('i', '<A-k>', '<C-\\><C-N><C-w>k')
vim.keymap.set('i', '<A-h>', '<C-\\><C-N><C-w>h')
vim.keymap.set('i', '<A-l>', '<C-\\><C-N><C-w>l')
vim.keymap.set('t', '<A-j>', '<C-\\><C-N><C-w>j')
vim.keymap.set('t', '<A-k>', '<C-\\><C-N><C-w>k')
vim.keymap.set('t', '<A-h>', '<C-\\><C-N><C-w>h')
vim.keymap.set('t', '<A-l>', '<C-\\><C-N><C-w>l')
vim.api.nvim_create_autocmd({ "TermOpen", "WinEnter" }, { pattern = "term://*", command = "startinsert" })
vim.keymap.set('t', '<Esc>', '<C-\\><C-N>')
vim.keymap.set('n', '<leader>l', ':cn<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>h', ':cp<cr>', { noremap = true, silent = true })
vim.keymap.set("n", "q", "<nop>", {})
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
