vim9script
set nocompatible backspace=2 noshowcmd laststatus=- smartcase showmatch nobackup noswapfile
set wildignore=*.o,*.obj,*.pyc,*.git noshowcmd noshowmode mouse=a nowritebackup title
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab smartindent autoindent incsearch noru
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
# ./configure  --with-features=tiny  --disable-acl  --disable-selinux  --disable-gpm  --disable-sysmouse  --disable-nls  --disable-xsmp  --disable-xsmp-interact  --disable-canberra  --disable-libsodium  --disable-luainterp  --disable-mzschemeinterp  --disable-perlinterp  --disable-python3interp  --disable-pythoninterp  --disable-tclinterp  --disable-rubyinterp  --disable-cscope  --disable-netbeans  --disable-channel  --disable-terminal  --disable-autoservername  --disable-rightleft  --disable-arabic  --disable-gui  --without-x  --with-tlib=ncurses
