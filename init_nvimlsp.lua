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
  "ggandor/leap.nvim",
  "NeogitOrg/neogit",
  "sindrets/diffview.nvim",
  "bluz71/vim-moonfly-colors",
  "tpope/vim-sleuth",
  "echasnovski/mini.pairs",
  "echasnovski/mini.completion",
  "nvim-lua/plenary.nvim",
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "mfussenegger/nvim-dap",
  "theHamsta/nvim-dap-virtual-text",
  "jay-babu/mason-nvim-dap.nvim",
  "rcarriga/nvim-dap-ui",
  "nvim-neotest/nvim-nio",
  "stevearc/overseer.nvim",
  "stevearc/oil.nvim",
  "j-hui/fidget.nvim",
  "nvim-lualine/lualine.nvim",
  "Bekaboo/dropbar.nvim",
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "nvim-telescope/telescope.nvim" , branch = "0.1.6"},
  { "nvim-telescope/telescope-fzf-native.nvim" , build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"},
}
vim.cmd("set termguicolors")
vim.g.moonflyWinSeparator = 2
vim.g.moonflyVirtualTextColor = true
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
vim.cmd('colorscheme moonfly')
require('overseer').setup{ dap = false }
require 'dap.ext.vscode'.json_decode = require "overseer.json".decode
require 'dap.ext.vscode'.load_launchjs(nil, { codelldb = { 'c', 'cpp', 'rust' } })
require 'overseer'.patch_dap(true)
require("dapui").setup()
local dap, dapui = require("dap"), require("dapui")
require("nvim-dap-virtual-text").setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
vim.keymap.set('n', '<leader>D', function() require('dapui').close() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end)
vim.keymap.set('n', '<leader>dj', function() require('dap').step_over() end)
vim.keymap.set('n', '<leader>dk', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp',
  function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function() require('dap.ui.widgets').hover() end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function() require('dap.ui.widgets').preview() end)
vim.keymap.set('n', '<Leader>dd', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "cpp", "rust", "zig", "go" },
  auto_install = false,
  highlight = { enable = true },
}
require('fidget').setup()
require('lualine').setup { options = {
  component_separators = { left = '', right = '' },
  section_separators = { left = '', right = '' },
}, sections = {
  lualine_a = { 'branch' },
  lualine_b = { 'filename' },
  lualine_c = { 'diff', '' },
  lualine_x = { '', '', 'diagnostics' },
  lualine_y = { 'location' },
  lualine_z = { 'searchcount' },
} }
require('neogit').setup{}
require('oil').setup()
require('mini.pairs').setup()
require('mini.completion').setup()
require('diffview').setup{ use_icons = false }
require('leap').create_default_mappings()
require('mason').setup()
require('mason-lspconfig').setup()
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
require('telescope').load_extension('fzf')
local builtin = require('telescope.builtin')
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
vim.keymap.set('n', '<leader>o', ':Oil --float<CR>')
vim.keymap.set('n', '<leader>t', ':sp | term<CR>')
vim.keymap.set('n', '<leader>g', ':Neogit<CR>')
vim.keymap.set('n', '<leader><leader>', ':nohlsearch<CR>')
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
