set nocompatible backspace=2 noshowcmd laststatus=- smartcase showmatch nobackup noswapfile
set completeopt=menuone,popup,fuzzy,noselect completepopup=highlight:Pmenu nowritebackup
set wildignore=*.o,*.obj,*.pyc,*.git titlestring=%t\ -\ %l:%c\ (%p%%) noshowcmd noshowmode
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab smartindent autoindent title incsearch
set fillchars+=eob:\  noerrorbells novisualbell belloff=all shortmess-=S shortmess+=I
inoremap <silent> ş <Esc>
vnoremap <silent> ş <Esc>
cnoremap <silent> ş <Esc>
nmap gl $
nmap gh 0
nmap gn :bn<cr>
nmap gp :bp<cr>
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
