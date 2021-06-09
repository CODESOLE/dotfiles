if has('termguicolors')
set termguicolors
endif
colorscheme default
set background=dark
hi CursorLine term=bold cterm=bold guibg=Grey40

" CDC = Change to Directory of Current file
command CDC cd %:p:h

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
nmap <leader><leader> :Vex<CR>

set encoding=UTF-8

set laststatus=2
set statusline=
set statusline+=%2*
set statusline+=%{StatuslineMode()}
set statusline+=%1*
set statusline+=\ 
set statusline+=\ 
set statusline+=%f
set statusline+=%1*
set statusline+=\ 
set statusline+=\ 
set statusline+=%m
set statusline+=\ 
set statusline+=%=
set statusline+=%h
set statusline+=%r
set statusline+=\ 
set statusline+=%3*
set statusline+=%{b:gitbranch}
set statusline+=%5*
set statusline+=%l
set statusline+=/
set statusline+=%L
set statusline+=%1*
set statusline+=|
set statusline+=%y
hi User2 ctermbg=lightgreen ctermfg=black guibg=lightgreen guifg=black
hi User1 ctermbg=black ctermfg=white guibg=black guifg=white
hi User3 ctermbg=black ctermfg=lightblue guibg=black guifg=lightblue
hi User4 ctermbg=black ctermfg=lightgreen guibg=black guifg=lightgreen
hi User5 ctermbg=black ctermfg=magenta guibg=black guifg=magenta

function! StatuslineMode()
  let l:mode=mode()
  if l:mode==#"n"
    return "NORMAL"
  elseif l:mode==?"v"
    return "VISUAL"
  elseif l:mode==#"i"
    return "INSERT"
  elseif l:mode==#"R"
    return "REPLACE"
  elseif l:mode==?"s"
    return "SELECT"
  elseif l:mode==#"t"
    return "TERMINAL"
  elseif l:mode==#"c"
    return "COMMAND"
  elseif l:mode==#"!"
    return "SHELL"
  endif
endfunction

function! StatuslineGitBranch()
  let b:gitbranch=""
  if &modifiable
    try
      let l:dir=expand('%:p:h')
      let l:gitrevparse = system("git -C ".l:dir." rev-parse --abbrev-ref HEAD")
      if !v:shell_error
        let b:gitbranch="(".substitute(l:gitrevparse, '\n', '', 'g').") "
      endif
    catch
    endtry
  endif
endfunction

augroup GetGitBranch
  autocmd!
  autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
augroup END

set is hlsearch
nmap <leader><CR> :nohlsearch<CR>
nnoremap j gj
nnoremap k gk
nnoremap <Up> gk
nnoremap <Down> gj
au VimEnter * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
au VimLeave * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'

nmap <leader>t :ter<CR>

nmap <leader>l :bn<CR>
nmap <leader>h :bp<CR>

inoremap <C-k> <C-o>gk
inoremap <C-j> <C-o>gj
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>l
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>

" paste selected texts to vpaste.net
vmap <leader><leader> <ESC>:exec "'<,'>w !vpaste.sh ft=".&ft<CR>

cnoremap Sw execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

map <F3> :!ctags -R --kinds-c++=+p --fields=+iaS --extras=+q .<CR>

nnoremap n nzz
nnoremap N Nzz

iabbrev __cc /*<CR><CR>/<Up>

au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main

set tags+=~/tags/tags

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI * if pumvisible() == 0|silent! pclose|endif
