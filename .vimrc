colorscheme torte
set t_Co=256
command CDC cd %:p:h
set laststatus=0 ruler
set nocompatible
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab
set mouse=a
set noshowmode
set path+=**
filetype on
filetype plugin on
set ignorecase
set smartcase
set showmatch
set wildmode=list,full
set wildmenu
set wildignore=*/builddir/*,*/build/*,tags
syntax enable
let mapleader=" "
set hidden
set cmdheight=1
set updatetime=200
set shortmess+=c
set nobackup
set omnifunc=syntaxcomplete#Complete
set nowritebackup
set noswapfile
set completeopt=menuone,menu,longest,preview
set clipboard=unnamedplus
noremap gl $
noremap gh 0
set cursorline
set splitbelow splitright
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_preview=1
let g:netrw_winsize=25
autocmd FileType netrw setl bufhidden=delete
set encoding=UTF-8
set is hlsearch
nmap <leader><CR> :nohlsearch<CR>
nnoremap j gj
nnoremap k gk
nnoremap <Up> gk
nnoremap <Down> gj
nmap <leader>t :ter<CR>
nmap <leader>l :bn<CR>
nmap <leader>h :bp<CR>
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
nnoremap n nzz
nnoremap N Nzz
