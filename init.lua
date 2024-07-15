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
  "bluz71/vim-moonfly-colors",
  "j-hui/fidget.nvim",
  "tpope/vim-sleuth",
  "mg979/vim-visual-multi",
  "kylechui/nvim-surround",
  "echasnovski/mini.completion",
  "akinsho/toggleterm.nvim",
  "echasnovski/mini.pairs",
  "echasnovski/mini.files",
  "ggandor/leap.nvim",
  "neovim/nvim-lspconfig",
  "theHamsta/nvim-dap-virtual-text",
  "mfussenegger/nvim-dap",
  "nvim-neotest/nvim-nio",
  "rcarriga/nvim-dap-ui",
  "nvim-lualine/lualine.nvim",
  "ibhagwan/fzf-lua",
  "nvim-treesitter/nvim-treesitter-context",
  "nvim-treesitter/nvim-treesitter-textobjects",
  { "nvim-treesitter/nvim-treesitter", build = ':TSUpdate' }
}
vim.o.shell = 'nu'
vim.o.shellcmdflag='-c'
vim.o.shellredir = '2>&1 | save --raw %s'
vim.o.shellpipe = '2>&1 | save --raw %s'
vim.o.shellquote = ""
vim.o.shellxquote = ""
vim.g.moonflyWinSeparator = 2
vim.g.moonflyVirtualTextColor = true
vim.o.updatetime = 500
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
require'fzf-lua'.setup {'fzf-native'}
require'toggleterm'.setup{ open_mapping = [[<C-s>]] }
vim.keymap.set("n", "<C-p>", ":ToggleTerm direction=float<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<C-m>", function() require('toggleterm.terminal').Terminal:new({ direction = "float", cmd = "lazygit", hidden = true }):toggle() end, {noremap = true, silent = true})
require'fidget'.setup()
require'mini.files'.setup{ windows = { preview = true } }
vim.keymap.set("n", "<leader>o", "<CMD>lua MiniFiles.open()<CR>", { silent = true })
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
require('lspconfig').gopls.setup{
  settings = {
    gopls = {
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      }
    }
  }
}
require('lspconfig').clangd.setup{}
require('lspconfig').zls.setup{}
require('lspconfig').rust_analyzer.setup{}
vim.filetype.add{ extension = { v = 'vlang' } }
require('lspconfig').v_analyzer.setup{ filetypes = { 'vlang' } }
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
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, opts)
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
require("dapui").setup()
require("nvim-dap-virtual-text").setup()
local dap, dapui = require("dap"), require("dapui")
dap.adapters.lldb = {
  type = 'executable',
  command = 'C:/Program Files/LLVM/bin/lldb-dap.exe',
  name = 'lldb'
}
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
