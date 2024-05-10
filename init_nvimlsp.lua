local function clone_paq()
  local path = vim.fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
  local is_installed = vim.fn.empty(vim.fn.glob(path)) == 0
  if not is_installed then
    vim.fn.system { "git", "clone", "--depth=1", "https://github.com/savq/paq-nvim.git", path }
    return true
  end
end

local function bootstrap_paq(packages)
  local first_install = clone_paq()
  vim.cmd.packadd("paq-nvim")
  local paq = require("paq")
  if first_install then
    vim.notify("Installing plugins... If prompted, hit Enter to continue.")
  end

  paq(packages)
  paq.install()
end

bootstrap_paq {
  "savq/paq-nvim",
  "puremourning/vimspector",
  "bluz71/vim-moonfly-colors",
  "tpope/vim-sleuth",
  "echasnovski/mini.pairs",
  "echasnovski/mini.completion",
  "tpope/vim-surround",
  "easymotion/vim-easymotion",
  "neovim/nvim-lspconfig",
  "j-hui/fidget.nvim",
  "nvim-lualine/lualine.nvim",
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope-file-browser.nvim",
  { "nvim-telescope/telescope.nvim" , branch = "0.1.6"},
}
vim.cmd 'let g:EasyMotion_smartcase = 1'
vim.cmd 'nmap s <Plug>(easymotion-overwin-f2)'
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
vim.o.hidden       = true
vim.o.signcolumn   = "no"
vim.g.mapleader    = ' '
vim.o.path="**"
vim.cmd('au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=500}')
vim.cmd('colorscheme moonfly')
require('fidget').setup()
require('lualine').setup { sections = {
  lualine_a = { 'branch' },
  lualine_b = { { 'filename', path = 1 } },
  lualine_c = { 'diff', '' },
  lualine_x = { '', '', 'diagnostics' },
  lualine_y = { 'location' },
  lualine_z = { 'searchcount' },
} }
require('mini.pairs').setup()
require('mini.completion').setup()
require('lspconfig').clangd.setup{}
require('lspconfig').rust_analyzer.setup{}
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>a', vim.lsp.buf.code_action, opts)
  end,
})
require('telescope').setup {
  pickers = {
    buffers = {
      mappings = {
        i = { ["<c-d>"] = "delete_buffer" },
        n = { ["d"] = "delete_buffer" },
      }
    }
  }
}
require("telescope").load_extension "file_browser"
local builtin = require('telescope.builtin')
vim.keymap.set("n", "<space>fm", ":Telescope file_browser<CR>")
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fl', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>fw', builtin.lsp_workspace_symbols, {})
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find, {})
vim.lsp.inlay_hint.enable(true)
vim.keymap.set('n', '<leader>t', ':sp | term<CR>')
vim.keymap.set('n', '<leader>g', ':!lazygit<CR>')
vim.keymap.set('n', '<leader><leader>', ':nohlsearch<CR>')
vim.keymap.set('n', 'gn', ':bn<CR>')
vim.keymap.set('n', 'gp', ':bp<CR>')
vim.keymap.set('i', '<C-k>', '<Up>')
vim.keymap.set('i', '<C-j>', '<Down>')
vim.keymap.set('i', '<C-h>', '<Left>')
vim.keymap.set('i', '<C-l>', '<Right>')
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
