if vim.g.vscode then -------------------------------------------------------------------------------------------------------------------------------------------------- VSCODE CONFIG
  local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
      fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
      vim.cmd [[packadd packer.nvim]]
      return true
    end
    return false
  end
  require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use { 'numToStr/Comment.nvim', config = function() require 'Comment'.setup {} end }
    use { 'windwp/nvim-autopairs', config = function() require("nvim-autopairs").setup {} end }
    use { 'kylechui/nvim-surround', config = function() require("nvim-surround").setup() end }
    use 'ggandor/leap.nvim'
    if ensure_packer() then
      require('packer').sync()
    end
  end)
  require('leap').add_default_mappings()
  vim.g.mapleader = ' '
  vim.keymap.set("x", "<leader>vp", [["_dP]])
  vim.keymap.set({ "n", "v" }, "<leader>vd", [["_d]])
  vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]])
  vim.keymap.set({ "n", "v" }, "<leader>P", [["+P]])
  vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
  vim.keymap.set({ "n", "v" }, "<leader>Y", [["+Y]])
  vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

  vim.keymap.set("n", "<leader>h", "<Cmd>Tabprevious<CR>")
  vim.keymap.set("n", "<leader>l", "<Cmd>Tabnext<CR>")

  vim.keymap.set('n', '<Leader><CR>', ':nohlsearch<CR>')
  vim.keymap.set('n', 'j', 'gj')
  vim.keymap.set('n', 'k', 'gk')
  vim.keymap.set('n', '<Up>', 'gk')
  vim.keymap.set('n', '<Down>', 'gj')
  vim.keymap.set('n', 'gl', '$')
  vim.keymap.set('n', 'gh', '0')
else ------------------------------------------------------------------------------------------------------------------------------------------------------------------ NVIM CONFIG
  local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
      fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
      vim.cmd [[packadd packer.nvim]]
      return true
    end
    return false
  end
  require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'HiPhish/rainbow-delimiters.nvim'
    use 'bluz71/vim-moonfly-colors'
    use 'neovim/nvim-lspconfig'
    use { 'nvim-treesitter/nvim-treesitter', run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
    }
    use 'lukas-reineke/indent-blankline.nvim'
    use 'debugloop/telescope-undo.nvim'
    -- use 'Bekaboo/dropbar.nvim'
    use { 'norcalli/nvim-colorizer.lua', config = function() require 'colorizer'.setup() end }
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'ggandor/leap.nvim'
    use 'lewis6991/gitsigns.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'NeogitOrg/neogit'
    use { 'nvim-telescope/telescope-fzf-native.nvim', run =
    'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.2', requires = { { 'nvim-lua/plenary.nvim' } } }
    use { 'numToStr/Comment.nvim', config = function() require 'Comment'.setup {} end }
    use { 'windwp/nvim-autopairs', config = function() require("nvim-autopairs").setup {} end }
    use 'nvim-lualine/lualine.nvim'
    use { 'sindrets/diffview.nvim', config = function() require 'diffview'.setup { use_icon = true } end }
    use { 'kylechui/nvim-surround', config = function() require("nvim-surround").setup() end }
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'
    use { 'nvim-tree/nvim-web-devicons', config = function() require 'nvim-web-devicons'.setup() end }
    use { 'williamboman/mason.nvim', run = ":MasonUpdate" }
    use { 'williamboman/mason-lspconfig.nvim' }
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'L3MON4D3/LuaSnip'
    use 'rafamadriz/friendly-snippets'
    use 'saadparwaiz1/cmp_luasnip'
    use 'arkav/lualine-lsp-progress'
    use { 'stevearc/oil.nvim', config = function() require('oil').setup() end }
    use { 'RRethy/vim-illuminate' }
    use { 'VonHeikemen/lsp-zero.nvim', branch = 'v2.x' }
    if ensure_packer() then
      require('packer').sync()
    end
  end)
  vim.g.loaded_netrw = 1
  vim.wo.wrap = false
  vim.g.updatetime = 200
  vim.wo.number = true
  vim.cmd [[set cursorlineopt=number]]
  vim.cmd [[set cursorline]]
  vim.g.loaded_netrwPlugin = 1
  vim.o.termguicolors = true
  vim.o.cmdheight = 0
  require("indent_blankline").setup { show_current_context = true, show_current_context_start = true, }
  vim.cmd [[colorscheme moonfly]]
  vim.cmd('au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=500}')
  vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "ColorColumn" })
  vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "ColorColumn" })
  vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "ColorColumn" })

  vim.bo.tabstop     = 2
  vim.o.tabstop      = 2
  vim.bo.shiftwidth  = 2
  vim.o.shiftwidth   = 2
  vim.bo.softtabstop = 2
  vim.o.softtabstop  = 2
  vim.bo.expandtab   = true
  vim.o.expandtab    = true
  vim.o.smarttab     = true
  vim.o.showmode     = false
  vim.o.splitbelow   = true
  vim.o.splitright   = true
  vim.o.swapfile     = false
  vim.bo.swapfile    = false
  vim.o.hlsearch     = true
  vim.o.smartcase    = true
  vim.o.ignorecase   = true
  vim.o.smartindent  = true
  vim.o.autoindent   = true
  vim.o.showmatch    = true
  vim.o.hidden       = true
  vim.g.mapleader    = ' '

  vim.keymap.set('n', '<Leader><CR>', ':nohlsearch<CR>')
  vim.keymap.set('n', 'j', 'gj')
  vim.keymap.set('n', 'k', 'gk')
  vim.keymap.set('n', '<Up>', 'gk')
  vim.keymap.set('n', '<Down>', 'gj')
  vim.keymap.set('n', 'gl', '$')
  vim.keymap.set('n', '<leader>t', ':belowright split |ter<CR>')
  vim.keymap.set('n', 'gn', ':bn<CR>')
  vim.keymap.set('n', 'gp', ':bp<CR>')
  vim.keymap.set('n', '<leader>m', '<cmd>Oil<CR>')
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
  require("dapui").setup()
  local dap, dapui = require("dap"), require("dapui")

  dap.adapters.codelldb = {
    type = 'server',
    port = "13000",
    executable = {
      command = vim.fn.stdpath('data') .. '/mason/bin/codelldb.cmd',
      args = { "--port", "13000" },

      -- On windows you may have to uncomment this:
      detached = false,
    }
  }
  dap.configurations.cpp = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file') .. '${workspaceFolderBasename}'
      end,
      cwd = '${workspaceFolder}',
      args = function()
        local args = {}
        for w in vim.fn.input('Args: ', '', 'file'):gmatch('%S+') do
          table.insert(args, w)
        end
        return args
      end,
    },
  }

  dap.configurations.c = dap.configurations.cpp
  dap.configurations.rust = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file') .. '${workspaceFolderBasename}'
      end,
      cwd = '${workspaceFolder}',
      args = function()
        local args = {}
        for w in vim.fn.input('Args: ', '', 'file'):gmatch('%S+') do
          table.insert(args, w)
        end
        return args
      end,
      initCommands = function()
        if jit.os == 'Linux' then
        -- Find out where to look for the pretty printer Python module
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
      else
        return nil
      end
      end
    },
  }

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end

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
    component_separators = { left = '|', right = '|' },
    section_separators = { left = '|', right = '' },
  }, sections = {
    lualine_a = { 'lsp_progress' },
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = { 'searchcount', '', '' },
    lualine_y = { 'progress' },
    lualine_z = { '' },
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
  require('telescope').load_extension('undo')
  vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
  vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', { noremap = false, silent = true })
  vim.keymap.set('n', '<leader>S', '<cmd>Telescope lsp_workspace_symbols<CR>', { noremap = false, silent = true })

  vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
  vim.keymap.set('n', '<leader>fl', builtin.live_grep, {})
  vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
  vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
  vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {})
  vim.keymap.set('n', '<leader>fk', builtin.keymaps, {})
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

  require 'neogit'.setup { integrations = { diffview = true }, use_telescope = true }
  require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "lua", "cpp", "cmake", "rust", "gdscript", "meson", "toml" },
    textobjects = {
      lsp_interop = {
        enable = true,
        border = 'none',
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

      map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
      map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
      map('n', '<leader>hS', gs.stage_buffer)
      map('n', '<leader>hu', gs.undo_stage_hunk)
      map('n', '<leader>hR', gs.reset_buffer)
      map('n', '<leader>hp', gs.preview_hunk)
      map('n', '<leader>hb', function() gs.blame_line { full = true } end)
      map('n', '<leader>tb', gs.toggle_current_line_blame)
      map('n', '<leader>hd', gs.diffthis)
      map('n', '<leader>hD', function() gs.diffthis('~') end)
      map('n', '<leader>td', gs.toggle_deleted)
    end
  }
  require('lsp-zero').nvim_workspace()
  require('lsp-zero').ensure_installed({ "lua_ls", "rust_analyzer", "clangd" })
  require('lsp-zero').preset({}).on_attach(function(client, bufnr)
    require('lsp-zero').preset({}).default_keymaps({ buffer = bufnr })
  end)
  require('lsp-zero').preset({}).setup()

  require 'cmp'.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = {
      ['<CR>'] = require 'cmp'.mapping.confirm({ select = false }),
      ['<C-Space>'] = require 'cmp'.mapping.complete(),
      ['<C-f>'] = require('lsp-zero').cmp_action().luasnip_jump_forward(),
      ['<C-b>'] = require('lsp-zero').cmp_action().luasnip_jump_backward(),
    },
    sources = require 'cmp'.config.sources({ { name = 'path' }, { name = 'nvim_lsp' }, { name = 'buffer' },
      { name = 'luasnip' }, { name = 'nvim_lsp_signature_help' }
    }),
  })

  require 'cmp'.setup.cmdline({ '/', '?' }, {
    mapping = require 'cmp'.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  require 'cmp'.setup.cmdline(':', {
    mapping = require 'cmp'.mapping.preset.cmdline(),
    sources = require 'cmp'.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  require 'lspconfig'.clangd.setup { cmd = { "clangd",
    "--background-index",
    "--clang-tidy",
    "--all-scopes-completion",
    "--completion-style=detailed",
    "--header-insertion-decorators",
    "--header-insertion=never" } }
  vim.keymap.set('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = false, silent = true })
  vim.keymap.set("x", "<leader>vp", [["_dP]])
  vim.keymap.set({ "n", "v" }, "<leader>vd", [["_d]])
  vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]])
  vim.keymap.set({ "n", "v" }, "<leader>P", [["+P]])
  vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
  vim.keymap.set({ "n", "v" }, "<leader>Y", [["+Y]])
  vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
  vim.g.rainbow_delimiters = {
    strategy = {
      [''] = require 'rainbow-delimiters'.strategy['global'],
      vim = require 'rainbow-delimiters'.strategy['local'],
    },
    query = { [''] = 'rainbow-delimiters', lua = 'rainbow-blocks', },
    highlight = {
      'RainbowDelimiterRed', 'RainbowDelimiterYellow', 'RainbowDelimiterBlue', 'RainbowDelimiterOrange',
      'RainbowDelimiterGreen', 'RainbowDelimiterViolet', 'RainbowDelimiterCyan', },
  }
end
