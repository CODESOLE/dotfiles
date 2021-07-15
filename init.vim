colorscheme torte
set t_Co=256
command CDC cd %:p:h
if has('termguicolors')
  set termguicolors
endif
au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=500}
set shell=bash
set laststatus=0 ruler
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab
set mouse=a
set noshowmode
set path+=**
set ignorecase
set smartcase
set showmatch
set wildmode=list,full
set wildignore=*/builddir/*,*/build/*,tags
let mapleader=" "
set hidden
set cmdheight=1
set updatetime=200
set shortmess+=c
set omnifunc=syntaxcomplete#Complete
set completeopt=menuone,menu,longest,preview
set clipboard=unnamed
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
nmap <leader><leader> :Vex<CR>
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
map <F3> :!ctags -R *<CR>
iabbrev __cc /*<CR><CR>/<Up>
