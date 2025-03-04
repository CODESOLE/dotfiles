vim.keymap.set("v", "ş", "<Esc>")
vim.keymap.set("c", "ş", "<Esc>")
vim.keymap.set("i", "ş", "<Esc>")
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
  "TaDaa/vimade",
  "bluz71/vim-moonfly-colors",
  "j-hui/fidget.nvim",
  "nmac427/guess-indent.nvim",
  "NeogitOrg/neogit",
  "NStefan002/visual-surround.nvim",
  { "saghen/blink.cmp", branch = 'v0.13.1' },
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
  "nvim-telescope/telescope.nvim",
  "sindrets/diffview.nvim",
  "nvim-lua/plenary.nvim",
  "nvim-treesitter/nvim-treesitter-context",
  "nvim-treesitter/nvim-treesitter-textobjects",
  { "nvim-telescope/telescope-fzf-native.nvim", build = 'make'},
  { "nvim-treesitter/nvim-treesitter", build = ':TSUpdate' }
}
vim.g.moonflyWinSeparator = 2
vim.g.moonflyItalics = false
vim.g.moonflyVirtualTextColor = true
vim.go.guicursor = "a:block"
vim.wo.wrap = false
vim.wo.list = true
vim.wo.listchars = "tab:> ,trail:-,nbsp:+,extends:>,precedes:<"
vim.go.fillchars = "eob: "
vim.o.updatetime = 200
vim.cmd.colorscheme('moonfly')
vim.api.nvim_set_hl(0, 'Normal', {bg='#000000'})
vim.api.nvim_set_hl(0, 'FloatBorder', {bg='#000000'})
vim.api.nvim_set_hl(0, 'NonText', {bg='#999999', fg='black'})
vim.api.nvim_set_hl(0, 'EndOfBuffer', {bg='NONE'})
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
vim.keymap.set("v", "<leader>y", '"*y', { silent = true })
vim.keymap.set("n", "<C-k>", ':tabn<cr>', { silent = true })
require('neogit').setup{}
vim.keymap.set("n", "<leader>g", require'neogit'.open, { silent = true, noremap = true })
require'toggleterm'.setup{ open_mapping = [[<C-j>]], shell = 'nu.exe' }
vim.keymap.set("n", "<C-p>", ":ToggleTerm direction=float<CR>", { silent = true, noremap = true })
require('guess-indent').setup {}
require'fidget'.setup()
require("diffview").setup({use_icons=false})
require'mini.files'.setup{ windows = { preview = true } }
vim.keymap.set("n", "<leader>o", "<CMD>lua MiniFiles.open()<CR>", { silent = true })
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "go", "c", "cpp", "rust", "toml", "zig", "lua", "query" },
  sync_install = false,
  auto_install = true,
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gN", -- set to `false` to disable one of the mappings
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = { enable = true },
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
      floating_preview_opts = { border = 'none' },
      peek_definition_code = {
        ["<leader>p"] = "@function.outer",
        ["<leader>P"] = "@class.outer",
      },
    },
  },
}
vim.wo.foldmethod = 'expr'
vim.o.foldenable = false
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
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
vim.keymap.set({'n', 'x', 'o'}, 's',  '<Plug>(leap)')
vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-from-window)')
require('mini.pairs').setup()
require('visual-surround').setup{enable_wrapped_deletion = true}
require('blink.cmp').setup{completion = { documentation = { auto_show = true } }, signature = {enabled = true}}
local capabilities = require('blink.cmp').get_lsp_capabilities()
require('lspconfig').gopls.setup{
  capabilities = capabilities,
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
require('lspconfig').clangd.setup{capabilities = capabilities}
require('lspconfig').zls.setup{capabilities = capabilities}
require('lspconfig').rust_analyzer.setup{capabilities = capabilities}
vim.filetype.add{ extension = { v = 'vlang' } }
require('lspconfig').v_analyzer.setup{ filetypes = { 'vlang' }, capabilities = capabilities}
local builtin = require('telescope.builtin')
require('telescope').setup {
  defaults = {
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
  },
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
    vim.keymap.set('n', '<space>fa', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, opts)
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
require("dapui").setup()
require("nvim-dap-virtual-text").setup()
local dap, dapui = require("dap"), require("dapui")
dap.adapters.lldb = {
  type = 'executable',
  command = 'C:/Program Files/LLVM/bin/lldb-dap.exe',
  name = 'lldb'
}
dap.configurations.cpp = {
  {
    name = '[LLDB] Launch Manually',
    type = 'lldb',
    request = 'launch',
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    program = function()
      local pickers = require("telescope.pickers")
      local finders = require("telescope.finders")
      local conf = require("telescope.config").values
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")
      return coroutine.create(function(coro)
        local opts = {}
        pickers
          .new(opts, {
            prompt_title = "Path to executable",
            finder = finders.new_oneshot_job({ "fd", "--hidden", "--no-ignore", "--type", "x" }, {}),
            sorter = conf.generic_sorter(opts),
            attach_mappings = function(buffer_number)
              actions.select_default:replace(function()
                actions.close(buffer_number)
                coroutine.resume(coro, action_state.get_selected_entry()[1])
              end)
              return true
            end,
          })
          :find()
      end)
    end,
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
    env = function()
      local variables = {}
      for k, v in pairs(vim.fn.environ()) do
        table.insert(variables, string.format("%s=%s", k, v))
      end
      table.insert(variables, function() return vim.fn.input('ENV var: ', '', 'file') end)
      return variables
    end,
  },
  {
    name = '[LLDB] Attach to Process',
    type = 'lldb',
    request = 'attach',
    pid = require('dap.utils').pick_process,
    args = {},
  },
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.zig = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
dap.configurations.rust[1].initCommands = function()
  if jit.os == "Linux" or jit.os == "BSD" or jit.os == "OSX" or jit.os == "POSIX" then
    local rustc_sysroot = vim.fn.trim(vim.fn.system('rustc --print sysroot'))
    local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
    local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'
    local commands = {}
    local file = io.open(commands_file, 'r')
    if file then
      for line in file:lines() do
        table.insert(commands, line)
      end
      file:close()
    end
    table.insert(commands, 1, script_import)
    return commands
  end
end
dap.configurations.rust[2].initCommands = dap.configurations.rust[1].initCommands
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
vim.keymap.set('n', '<leader>D', function() require('dapui').close() vim.cmd'set signcolumn=no' end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end)
vim.keymap.set('n', '<leader>dj', function() require('dap').step_over() end)
vim.keymap.set('n', '<leader>dk', function() require('dap').step_into() end)
vim.keymap.set('n', '<leader>do', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>db', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>de', ':DapTerminate<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>b', function()
  require('dap').list_breakpoints()
  vim.cmd('copen')
end)
vim.keymap.set('n', '<Leader>c', function()
  require('dap').clear_breakpoints()
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
