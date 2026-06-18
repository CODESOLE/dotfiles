vim.keymap.set('n', 'gl', '$')
vim.keymap.set('n', 'gh', '0')
vim.keymap.set('n', 'gn', ':bn<CR>')
vim.keymap.set('n', 'gp', ':bp<CR>')
vim.keymap.set('i', '<C-k>', '<Up>')
vim.keymap.set('i', '<C-j>', '<Down>')
vim.keymap.set('i', '<C-g>', '<Left>')
vim.keymap.set('i', '<C-l>', '<Right>')
vim.keymap.set('c', '<C-j>', '<Down>')
vim.keymap.set('c', '<C-k>', '<Up>')
vim.keymap.set('c', '<C-g>', '<Left>')
vim.keymap.set('c', '<C-l>', '<Right>')
vim.keymap.set('n', '<leader>l', ':cn<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>h', ':cp<cr>', { noremap = true, silent = true })
vim.keymap.set("n", "q", "<nop>", {})
vim.keymap.set("n", "<C-t>", ":vs | term<CR>", {noremap = true})
vim.keymap.set({'n', 'v', 'i', 'c' }, 'ş', '<Esc>')
vim.keymap.set('t', 'ş', '<C-\\><C-N>')
vim.wo.wrap = false
vim.wo.list = true
vim.wo.listchars = "tab:> ,trail:-,nbsp:+,extends:>,precedes:<"
vim.o.showmode     = false
vim.o.swapfile     = false
vim.o.backup       = false
vim.o.writebackup  = false
vim.o.smartcase    = true
vim.o.ignorecase   = true
vim.o.smartindent  = true
vim.o.autoindent   = true
vim.o.showmatch    = true
vim.o.cmdheight    = 0
vim.o.signcolumn   = "no"
vim.g.mapleader    = ' '
vim.diagnostic.config({ virtual_text = true })
vim.cmd('au TextYankPost * silent! lua vim.hl.on_yank {higroup="IncSearch", timeout=500}')
vim.g.vimtex_view_method = "zathura"
vim.cmd.colorscheme("vim")
vim.o.autocomplete       = true
vim.o.autocompletedelay  = 200
vim.o.complete = ".,w,b,o"
vim.o.completeopt = "menuone,noselect,fuzzy"
vim.o.pumheight = 10
vim.o.pummaxwidth = 80
vim.opt.shortmess:append("c")
vim.pack.add({
  "https://github.com/lervag/vimtex",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/echasnovski/mini.pairs",
  "https://github.com/echasnovski/mini.files",
  "https://codeberg.org/andyg/leap.nvim",
  "https://github.com/ibhagwan/fzf-lua",
})
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
vim.keymap.set('n', '<leader><leader>', ':FzfLua global<CR>', {silent = true, noremap = true})
vim.keymap.set('n', '<leader>g',  ':FzfLua live_grep<CR>', {silent = true, noremap = true})
require('mini.pairs').setup()
require'mini.files'.setup{ windows = { preview = true } }
vim.keymap.set("n", "<leader>o", "<CMD>lua MiniFiles.open()<CR>", { silent = true })
vim.keymap.set({'n', 'x', 'o'}, 's',  '<Plug>(leap)')
vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-from-window)')
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    vim.lsp.completion.enable(true, ev.data.client_id, ev.buf)
    vim.bo[ev.buf].complete = ".,w,b,o"
    local opts = { buffer = ev.buf }
    vim.keymap.set({'n', 'v'}, '<space>F', vim.lsp.buf.format, opts)
  end,
})
vim.lsp.inlay_hint.enable(true)
vim.lsp.enable({ 'texlab', 'ols', 'clangd'})
