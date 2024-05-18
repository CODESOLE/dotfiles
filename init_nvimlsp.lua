require 'paq' {
  "savq/paq-nvim",
  "bluz71/vim-moonfly-colors",
  "tpope/vim-sleuth",
  "kylechui/nvim-surround",
  "echasnovski/mini.completion",
  "echasnovski/mini.pairs",
  "ggandor/leap.nvim",
  "neovim/nvim-lspconfig",
  "mfussenegger/nvim-dap",
  "nvim-neotest/nvim-nio",
  "rcarriga/nvim-dap-ui",
  "theHamsta/nvim-dap-virtual-text",
  "nvim-lualine/lualine.nvim",
  "ibhagwan/fzf-lua",
  "Bekaboo/dropbar.nvim",
  "nvim-treesitter/nvim-treesitter-textobjects",
  { "nvim-treesitter/nvim-treesitter", build = ':TSUpdate' }
}
vim.g.moonflyWinSeparator = 2
vim.g.moonflyVirtualTextColor = true
vim.cmd('colorscheme moonfly')
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
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "go", "c", "cpp", "rust", "toml", "zig", "lua", "vim", "vimdoc", "query" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  textobjects = {
    swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
    },
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
      },
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      include_surrounding_whitespace = true,
    },
    lsp_interop = {
      enable = true,
      floating_preview_opts = { border = 'rounded' },
      peek_definition_code = {
        ["<leader>p"] = "@function.outer",
        ["<leader>P"] = "@class.outer",
      },
    },
  },
}
require('lualine').setup { options = { icons_enabled = false, section_separators = '', component_separators = '' }, sections = {
  lualine_a = { 'branch' },
  lualine_b = { 'filename' },
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
vim.keymap.set('n', '<leader>g', ':tabnew term://lazygit<CR>')
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
require("dapui").setup()
require("nvim-dap-virtual-text").setup()
local dap, dapui = require("dap"), require("dapui")
dap.adapters.codelldb = {
  type = 'server',
  port = "13000",
  executable = {
    command = vim.fn.stdpath('data') .. '/codelldb/extension/adapter/codelldb',
    args = { "--port", "13000" },
    -- On windows you may have to uncomment this:
    detached = false,
  }}
dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'codelldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = function()
      local args = vim.fn.input('Args: ', '', 'file')
      local words = {}
      for v in args:gmatch('%S+') do
        table.insert(words, v)
      end
      if #words == 0 then
        return {}
      end
      return words
    end,
  },
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
  vim.cmd'set signcolumn=yes'
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
  vim.cmd'set signcolumn=yes'
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
  vim.cmd'set signcolumn=no'
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
  vim.cmd'set signcolumn=no'
end
vim.keymap.set('n', '<leader>D', function() require('dapui').close() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end)
vim.keymap.set('n', '<leader>dj', function() require('dap').step_over() end)
vim.keymap.set('n', '<leader>dk', function() require('dap').step_into() end)
vim.keymap.set('n', '<leader>do', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function()
  require('dap').list_breakpoints()
  vim.cmd('copen')
end)
vim.keymap.set('n', '<Leader>c', function()
  require('dap').clear_breakpoints()
  vim.cmd('copen')
end)
vim.keymap.set('n', '<Leader>dt', function() require('dap').run_to_cursor() end)
vim.keymap.set('n', '<Leader><Up>', function() require('dap').up() end)
vim.keymap.set('n', '<Leader><Down>', function() require('dap').down() end)
vim.keymap.set('n', '<Leader>L',
  function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function() require('dap.ui.widgets').hover() end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function() require('dap.ui.widgets').preview() end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)
