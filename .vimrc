packadd lsp
packadd vim-easymotion
packadd vim-surround
packadd vim-commentary
packadd! editorconfig
nnoremap s <Plug>(easymotion-s2)
set bg=dark
set termguicolors
colorscheme retrobox
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set gp=git\ grep\ -rn
set backspace=2
set shortmess-=S
set signcolumn=no
set noshowcmd
set noshowmode
set noruler
set laststatus=-
set wildmode=list,full
set wildmenu
set wildignore=*/builddir/*,*/build/*,tags,node_modules/*,.git/*,.cache/*,.clangd/*,target/*
set path+=**
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab
syntax enable
set mouse=a
filetype on
filetype plugin on
set ignorecase
set smartcase
set showmatch
let mapleader=" "
set clipboard=unnamed
set clipboard+=unnamedplus
noremap gl $
noremap gh 0
set splitbelow splitright
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_preview=1
let g:netrw_winsize=25
autocmd FileType netrw setl bufhidden=delete
set is hlsearch
nmap <leader><CR> :nohlsearch<CR>
nmap gn :bn<CR>
nmap gp :bp<CR>
nnoremap <leader>l :cn<cr>
nnoremap <leader>h :cp<cr>
nnoremap <leader>o :LspOutline<cr>
nnoremap <leader>O :lcl<cr>
nnoremap <leader>n :tabn<CR>
nnoremap <leader>p :tabp<CR>
nnoremap <leader>L :Lex<CR>
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
nnoremap <leader>H <C-w>t<C-w>H
nnoremap <leader>K <C-w>t<C-w>K
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
set encoding=utf-8
set nobackup
set nowritebackup
set noswapfile
set updatetime=200
set guioptions=Ace
inoremap ş <Esc>:nohlsearch<cr>
vnoremap ş <Esc>:nohlsearch<cr>
cnoremap ş <Esc>:nohlsearch<cr>
call LspAddServer([#{
	\    name: 'clangd',
	\    filetype: ['c', 'cpp'],
	\    path: '/data/data/com.termux/files/usr/bin/clangd',
	\    args: ['--background-index','--all-scopes-completion','--header-insertion=never',]
	\  }])
call LspAddServer([#{
	\    name: 'rustlang',
	\    filetype: ['rust'],
	\    path: '/data/data/com.termux/files/usr/bin/rust-analyzer',
	\    args: [],
	\    syncInit: v:true
	\  }])
call LspOptionsSet(#{
        \   aleSupport: v:false,
        \   autoComplete: v:true,
        \   autoHighlight: v:true,
        \   autoHighlightDiags: v:true,
        \   autoPopulateDiags: v:true,
        \   completionMatcher: 'fuzzy',
        \   completionMatcherValue: 1,
        \   diagSignErrorText: 'E>',
        \   diagSignHintText: 'H>',
        \   diagSignInfoText: 'I>',
        \   diagSignWarningText: 'W>',
        \   echoSignature: v:false,
        \   hideDisabledCodeActions: v:false,
        \   highlightDiagInline: v:true,
        \   hoverInPreview: v:false,
        \   ignoreMissingServer: v:false,
        \   keepFocusInDiags: v:true,
        \   keepFocusInReferences: v:true,
        \   completionTextEdit: v:true,
        \   diagVirtualTextAlign: 'after',
        \   diagVirtualTextWrap: 'truncate',
        \   noNewlineInCompletion: v:true,
        \   omniComplete: v:false,
        \   outlineOnRight: v:true,
        \   outlineWinSize: 30,
        \   semanticHighlight: v:true,
        \   showDiagInBalloon: v:true,
        \   showDiagInPopup: v:true,
        \   showDiagOnStatusLine: v:false,
        \   showDiagWithSign: v:true,
        \   showDiagWithVirtualText: v:true,
        \   showInlayHints: v:true,
        \   showSignature: v:true,
        \   snippetSupport: v:false,
        \   ultisnipsSupport: v:false,
        \   useBufferCompletion: v:false,
        \   usePopupInCodeAction: v:true,
        \   useQuickfixForLocations: v:false,
        \   vsnipSupport: v:false,
        \   bufferCompletionTimeout: 100,
        \   customCompletionKinds: v:false,
        \   completionKinds: {},
        \   filterCompletionDuplicates: v:false,
	\ })
hi LspInlayHintsParam guibg=#111111 guifg=#444444
hi LspInlayHintsType guibg=#111111 guifg=#444444
nnoremap <leader>ac :LspCodeAction<CR>
nnoremap <leader>e :LspDiag show<CR>
nnoremap <leader>l :LspDiag next<CR>
nnoremap <leader>h :LspDiag prev<CR>
nnoremap <leader>d :LspDiag current<CR>
nnoremap <leader>s :LspDocumentSymbol<CR>
nnoremap <leader>ws :LspSymbolSearch<CR>
nnoremap <leader>f :LspFormat<CR>
nnoremap K :LspHover<CR>
nnoremap gd :LspGotoDefinition<CR>
nnoremap gy :LspGotoDeclaration<CR>
nnoremap gi :LspGotoImpl<CR>
nnoremap gt :LspGotoTypeDef<CR>
nnoremap <leader>rp :LspPeekReferences<CR>
nnoremap <leader>rn :LspRename<CR>
nnoremap gs :LspShowSignature<CR>
