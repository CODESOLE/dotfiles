vim.keymap.set("v", "<leader>y", '"*y')
vim.keymap.set("v", "<leader>p", '"*p')
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
vim.keymap.set('t', '<A-m>', '<C-\\><C-N>')
vim.keymap.set('n', '<leader>l', ':cn<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>h', ':cp<cr>', { noremap = true, silent = true })
vim.keymap.set("n", "q", "<nop>", {})
vim.keymap.set("n", "<leader>t", ":sp | term<CR>")
vim.go.guicursor = "a:block"
vim.wo.wrap = false
vim.wo.list = true
vim.wo.listchars = "tab:> ,trail:-,nbsp:+,extends:>,precedes:<"
vim.o.updatetime = 200
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
vim.keymap.set({'n', 'v', 'i', 'c' }, 'ş', '<Esc>')
vim.diagnostic.config({ virtual_text = true })
vim.cmd('au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=500}')
vim.cmd('packadd! nohlsearch')
vim.pack.add({
  "https://github.com/NStefan002/visual-surround.nvim",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/nmac427/guess-indent.nvim",
  "https://github.com/bluz71/vim-moonfly-colors",
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/saghen/blink.cmp",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/echasnovski/mini.pairs",
  "https://github.com/echasnovski/mini.files",
  "https://github.com/ggandor/leap.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope.nvim"
})
vim.g.moonflyWinSeparator = 2
vim.g.moonflyItalics = false
vim.g.moonflyVirtualTextColor = true
vim.cmd.colorscheme('moonfly')
require('visual-surround').setup{enable_wrapped_deletion = true}
require('lualine').setup { options = { icons_enabled = false, section_separators = '', component_separators = '' }, sections = {
  lualine_a = { 'branch' },
  lualine_b = { 'fileformat', 'encoding', 'filetype' },
  lualine_c = { 'filesize', 'filename', 'diff' },
  lualine_x = { 'diagnostics', '%L', 'selectioncount', 'progress' },
  lualine_y = { 'location' },
  lualine_z = { 'searchcount' },
}, inactive_sections = {
  lualine_a = { 'branch' },
  lualine_b = { 'fileformat', 'encoding', 'filetype' },
  lualine_c = { 'filesize', 'filename', 'diff' },
  lualine_x = { 'diagnostics', '%L', 'selectioncount', 'progress' },
  lualine_y = { 'location' },
  lualine_z = { 'searchcount' },
} }
local builtin = require('telescope.builtin')
require('telescope').setup {}
vim.keymap.set('n', '<leader>ff', ':Telescope find_files no_ignore=true<CR>', {silent = true, noremap = true})
vim.keymap.set('n', '<leader>fl', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>fw', builtin.lsp_dynamic_workspace_symbols, {})
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find, {})
require('guess-indent').setup {}
require("blink.cmp").setup({
  completion = {
    documentation = {
      auto_show = true,
    },
  },
  fuzzy = {
    implementation = "lua",
  },
})
require('mini.pairs').setup()
require'mini.files'.setup{ windows = { preview = true } }
vim.keymap.set("n", "<leader>o", "<CMD>lua MiniFiles.open()<CR>", { silent = true })
vim.keymap.set({'n', 'x', 'o'}, 's',  '<Plug>(leap)')
vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-from-window)')
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    local opts = { buffer = ev.buf }
    vim.keymap.set({'n', 'v'}, '<space>F', vim.lsp.buf.format, opts)
    if vim.lsp.get_client_by_id(ev.data.client_id).server_capabilities.documentHighlightProvider then
          vim.cmd [[
            hi! LspReferenceRead cterm=bold ctermbg=Gray guibg=#323437
            hi! LspReferenceText cterm=bold ctermbg=Gray guibg=#323437
            hi! LspReferenceWrite cterm=bold ctermbg=Gray guibg=#323437
          ]]
          vim.api.nvim_create_augroup('lsp_document_highlight', { clear = false })
          vim.api.nvim_clear_autocmds({
            buffer = ev.buf,
            group = 'lsp_document_highlight',
          })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            group = 'lsp_document_highlight',
            buffer = ev.buf,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            group = 'lsp_document_highlight',
            buffer = ev.buf,
            callback = vim.lsp.buf.clear_references,
          })
    end
  end,
})
vim.lsp.inlay_hint.enable(true)
vim.lsp.enable('gdscript')
vim.lsp.enable('zls')
vim.lsp.enable('ols')
vim.lsp.enable('clangd')
vim.lsp.enable('rust_analyzer')
vim.api.nvim_set_hl(0, 'Normal', {bg='#000000'})
