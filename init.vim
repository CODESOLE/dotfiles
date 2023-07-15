call plug#begin('~/AppData/Local/nvim/plugged')
Plug 'bluz71/vim-moonfly-colors'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'ggandor/leap.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'NeogitOrg/neogit'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.2' }
Plug 'gpanders/editorconfig.nvim'
Plug 'numToStr/Comment.nvim'
Plug 'cohama/lexima.vim'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
call plug#end()

function! GitGetCurrentBranch()
    :let s:branch_name = system("git rev-parse --abbrev-ref HEAD")
    :let s:notidx = match(s:branch_name, 'fatal: not a git repository')
    :if s:notidx == -1
        :let s:branch_name = strtrans(s:branch_name)
        :let s:branch_name = s:branch_name[:-3]
        :return '(' . s:branch_name . ') '
    :endif
    :return ''
endfunction

colorscheme moonfly
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat=%f:%l:%c:%m
set termguicolors
au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=500}
set makeprg=./build.sh
set statusline=\ %{GitGetCurrentBranch()}\ %<%f\ %m%r\ %=%l/%L\ %4v\ %P\ 
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab
set mouse=a
set noshowmode
set path+=**
set ignorecase
set smartcase
set smartindent
set autoindent
set showmatch
set wildmode=list,full
set wildignore=*/build*/*,tags,*.out,*/bin/*,*/node_modules/*,*/doc/*
let mapleader=" "
set hidden
set cmdheight=1
set updatetime=200
set shortmess+=c
set completeopt=menu,menuone,noselect
set clipboard=unnamedplus
noremap gl $
noremap gh 0
set cursorline
set splitbelow splitright
nmap <leader><CR> :nohlsearch<CR>
nnoremap j gj
nnoremap k gk
nnoremap <Up> gk
nnoremap <Down> gj
nmap <leader>t :ter<CR>
nmap <leader>l :bn<CR>
nmap <leader>h :bp<CR>
nmap <leader>m :NvimTreeToggle<CR>
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
vmap <leader><leader> <ESC>:exec "'<,'>w !vpaste.sh ft=".&ft<CR>
nmap <silent> <M-o> :ClangdSwitchSourceHeader<CR>

lua <<EOF
local builtin = require('telescope.builtin')

-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

local nvim_lsp = require('lspconfig')
local cmp = require('cmp')
cmp.setup({
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

require'neogit'.setup{}
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
require'nvim-tree'.setup{ renderer={icons={show = { file = false, folder = false, folder_arrow = false }}} }
require'Comment'.setup{}
require('gitsigns').setup{
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', '<leader>hj', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '<leader>hk', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)
  end
}
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('i', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
end
local servers = { 'clangd', 'rust_analyzer' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach, capabilities = capabilities }
  nvim_lsp['clangd'].setup{ on_attach = on_attach,
                            capabilities = capabilities,
                            cmd = {"clangd",
                                   "--background-index",
                                   "--clang-tidy",
                                   "--all-scopes-completion",
                                   "--completion-style=detailed",
                                   "--header-insertion-decorators",
                                   "--header-insertion=never"}}
end
EOF
