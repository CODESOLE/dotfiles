vim.cmd("language en_US")
vim.cmd("set termguicolors")
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
  {
    "luukvbaal/statuscol.nvim",
    build = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        segments = {
          {
            sign = { name = { "Diagnostic" }, auto = true },
            click = "v:lua.ScSa"
          },
          {
            sign = { name = { "Dap*" }, auto = true },
            click = "v:lua.ScSa"
          },
          { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa", },
          {
            sign = { namespace = { "gitsign*" } },
            click = "v:lua.ScSa"
          }
        }
      })
    end,
  },
  {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    build = function()
      require("fidget").setup()
    end,
  },
  'bluz71/vim-moonfly-colors',
  'neovim/nvim-lspconfig',
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  },
  'lukas-reineke/indent-blankline.nvim',
  'mg979/vim-visual-multi',
  'nvim-tree/nvim-web-devicons',
  { 'stevearc/overseer.nvim',      build = function() require('overseer').setup({ dap = false, }) end },
  'Bekaboo/dropbar.nvim',
  { 'norcalli/nvim-colorizer.lua', build = function() require 'colorizer'.setup() end },
  'nvim-treesitter/nvim-treesitter-textobjects',
  'lewis6991/gitsigns.nvim',
  'nvim-lua/plenary.nvim',
  'nvim-neotest/nvim-nio',
  'NeogitOrg/neogit',
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
    requires = {
      { 'nvim-lua/plenary.nvim' } }
  },
  {
    'stevearc/oil.nvim',
    build = function()
      require('oil').setup { view_options = {
        show_hidden = true } }
    end
  },
  'ggandor/leap.nvim',
  { 'numToStr/Comment.nvim',                    build = function() require 'Comment'.setup {} end },
  { 'kylechui/nvim-surround',                   build = function() require("nvim-surround").setup() end },
  { 'windwp/nvim-autopairs',                    build = function() require("nvim-autopairs").setup {} end },
  'nvim-lualine/lualine.nvim',
  { 'sindrets/diffview.nvim',           build = function() require 'diffview'.setup { _icon = true } end },
  'theHamsta/nvim-dap-virtual-text',
  'mfussenegger/nvim-dap',
  'rcarriga/nvim-dap-ui',
  { 'karb94/neoscroll.nvim',            build = function() require "neoscroll".setup() end },
  { 'williamboman/mason.nvim',          build = ":MasonUpdate" },
  { 'williamboman/mason-lspconfig.nvim' },
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp-signature-help',
  'L3MON4D3/LuaSnip',
  'rafamadriz/friendly-snippets',
  'saadparwaiz1/cmp_luasnip',
}

vim.g.loaded_netrw = 1
vim.wo.wrap = false
vim.wo.number = true
vim.g.updatetime = 200
vim.g.loaded_netrwPlugin = 1
vim.o.cmdheight = 0
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.g.moonflyWinSeparator = 2
vim.cmd [[
if exists('&cursorlineopt')
    set cursorlineopt=number
    set cursorline
endif
]]
vim.cmd [[colorscheme moonfly]]
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
vim.cmd('au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=500}')

vim.bo.tabstop     = 2
vim.o.tabstop      = 2
vim.bo.shiftwidth  = 2
vim.o.shiftwidth   = 2
vim.bo.softtabstop = 2
vim.o.softtabstop  = 2
vim.bo.expandtab   = true
vim.o.expandtab    = true
vim.o.showmode     = false
vim.o.splitbelow   = true
vim.o.splitright   = true
vim.o.swapfile     = false
vim.bo.swapfile    = false
vim.o.smartcase    = true
vim.o.ignorecase   = true
vim.o.smartindent  = true
vim.o.autoindent   = true
vim.o.showmatch    = true
vim.o.hidden       = true
vim.g.mapleader    = ' '

vim.keymap.set('n', '<Leader><CR>', ':nohlsearch<CR>')
vim.keymap.set('n', '<Leader>g', '<Cmd>Neogit<CR>')
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('n', '<Up>', 'gk')
vim.keymap.set('n', '<Down>', 'gj')
vim.keymap.set('n', 'gl', '$')
vim.keymap.set('n', '<leader>t', '<Cmd>sp term://bash<CR>')
vim.cmd [[autocmd BufEnter * if &buftype == 'terminal' | :startinsert | endif]]
vim.keymap.set('n', 'gn', ':bn<CR>')
vim.keymap.set('n', 'gp', ':bp<CR>')
vim.keymap.set('n', '<leader>m', require('oil').open_float)
vim.keymap.set('n', 'gh', '0')
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

vim.keymap.set('t', '<Esc>', '<C-\\><C-N>')

vim.keymap.set('n', '<leader>th', '<C-w>t<C-w>H', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tv', '<C-w>t<C-w>K', { noremap = true, silent = true })

require("dapui").setup()
local dap, dapui = require("dap"), require("dapui")
require("nvim-dap-virtual-text").setup()
dap.adapters.codelldb = {
  type = 'server',
  port = "13000",
  executable = {
    command = vim.fn.stdpath('data') .. '/mason/bin/codelldb',
    args = { "--port", "13000" },

    -- On windows you may have to uncomment this:
    -- detached = false,
  }
}
require 'dap.ext.vscode'.json_decode = require "overseer.json".decode
require 'dap.ext.vscode'.load_launchjs(nil, { codelldb = { 'c', 'cpp', 'rust' } })
require 'overseer'.patch_dap(true)
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

local builtin = require('telescope.builtin')
require('leap').add_default_mappings()
require('lualine').setup { options = {
  component_separators = { left = '', right = '' },
  section_separators = { left = '', right = '' },
}, sections = {
  lualine_a = { 'branch' },
  lualine_b = { 'diff', 'diagnostics' },
  lualine_c = { 'filename' },
  lualine_x = { '', '', '' },
  lualine_y = { '' },
  lualine_z = { 'searchcount' },
} }

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

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fF', '<cmd>Telescope current_buffer_fuzzy_find<CR>', { noremap = false, silent = true })
vim.keymap.set('n', '<leader>fl', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>fk', builtin.keymaps, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

require 'neogit'.setup { integrations = { diffview = true }, use_telescope = true }
vim.api.nvim_create_augroup("neogit-additions", {})
vim.api.nvim_create_autocmd("FileType", {
  group = "neogit-additions",
  pattern = "NeogitCommitMessage",
  command = "silent! set filetype=gitcommit",
})
require 'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "cpp", "cmake", "rust", "gdscript", "meson", "toml" },
  textobjects = {
    lsp_interop = {
      enable = true,
      border = 'rounded',
      floating_preview_opts = {},
      peek_definition_code = {
        ["<leader>df"] = "@function.outer",
        ["<leader>dF"] = "@class.outer",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = { query = "@class.outer", desc = "Next class start" },
        ["]o"] = "@loop.*",
        ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
        ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
      goto_next = {
        ["]d"] = "@conditional.outer",
      },
      goto_previous = {
        ["[d"] = "@conditional.outer",
      }
    },
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
        ['@function.outer'] = 'V',  -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      include_surrounding_whitespace = true,
    },
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
require('gitsigns').setup {
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map('n', '<leader>hj', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    map('n', '<leader>hk', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    vim.keymap.set('n', '<leader>hn', gs.next_hunk)
    vim.keymap.set('n', '<leader>hp', gs.prev_hunk)
    vim.keymap.set('n', '<leader>hs', gs.stage_hunk)
    vim.keymap.set('n', '<leader>hr', gs.reset_hunk)
    vim.keymap.set('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
    vim.keymap.set('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
    vim.keymap.set('n', '<leader>hS', gs.stage_buffer)
    vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk)
    vim.keymap.set('n', '<leader>hR', gs.reset_buffer)
    vim.keymap.set('n', '<leader>hh', gs.preview_hunk)
    vim.keymap.set('n', '<leader>hb', function() gs.blame_line { full = true } end)
    vim.keymap.set('n', '<leader>hd', gs.diffthis)
    vim.keymap.set('n', '<leader>hD', function() gs.diffthis('~') end)

    -- Text object
    vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}
local handlers = {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    require("lspconfig")[server_name].setup {
      capabilities = capabilities,
    }
  end,
  -- Next, you can provide targeted overrides for specific servers.
  ["clangd"] = function()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    require 'lspconfig'.clangd.setup {
      capabilities = capabilities,
      cmd = { "clangd",
        "--background-index",
        "--clang-tidy",
        "--all-scopes-completion",
        "--completion-style=detailed",
        "--header-insertion-decorators",
        "--header-insertion=never" } }
  end,
  ["lua_ls"] = function()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local lspconfig = require("lspconfig")
    lspconfig.lua_ls.setup {
      capabilities, capabilities,
      settings = {
        Lua = {
          hint = {
            enable = true,
          },
          diagnostics = {
            globals = { "vim" }
          }
        }
      }
    }
  end,
}

require('mason').setup()
require('mason-lspconfig').setup { handlers = handlers, ensure_installed = { "lua_ls", "rust_analyzer", "clangd" } }
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
    })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "rounded",
    })
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    vim.keymap.set('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { buffer = bufnr })
    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', { buffer = bufnr })
    vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', { buffer = bufnr })
    vim.keymap.set('n', '<leader>S', '<cmd>Telescope lsp_workspace_symbols<CR>', { buffer = bufnr })

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<space>F', function()
      vim.lsp.buf.format { async = true }
    end, opts)

    if vim.lsp.get_client_by_id(ev.data.client_id).server_capabilities.documentHighlightProvider then
      vim.cmd [[
    hi! LspReferenceRead cterm=bold ctermbg=red guibg=Gray
    hi! LspReferenceText cterm=bold ctermbg=red guibg=Gray
    hi! LspReferenceWrite cterm=bold ctermbg=red guibg=Gray
  ]]
      vim.api.nvim_create_augroup('lsp_document_highlight', {
        clear = false
      })
      vim.api.nvim_clear_autocmds({
        buffer = bufnr,
        group = 'lsp_document_highlight',
      })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        group = 'lsp_document_highlight',
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        group = 'lsp_document_highlight',
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
      })
    end

    if vim.lsp.get_client_by_id(ev.data.client_id).server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true)
    end
  end,
})
local cmp = require 'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({ { name = 'path' }, { name = 'nvim_lsp' }, { name = 'buffer' },
    { name = 'luasnip' }, { name = 'nvim_lsp_signature_help' }
  }),
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
vim.keymap.set("x", "<leader>vp", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>vd", [["_d]])
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]])
vim.keymap.set({ "n", "v" }, "<leader>P", [["+P]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set({ "n", "v" }, "<leader>Y", [["+Y]])
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = "󰋽 " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
vim.fn.sign_define('DapBreakpoint', { text = '⚫', texthl = 'red', linehl = '', numhl = '' })

require("ibl").setup()
