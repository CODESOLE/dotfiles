if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'machakann/vim-highlightedyank'
Plug 'ycm-core/YouCompleteMe'
Plug 'mg979/vim-visual-multi'
Plug 'morhetz/gruvbox'
Plug 'sheerun/vim-polyglot'
Plug 'puremourning/vimspector'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'preservim/nerdcommenter'
Plug 'airblade/vim-rooter'
Plug 'jiangmiao/auto-pairs'

call plug#end()

colorscheme gruvbox
set background=dark
let g:gruvbox_contrast_dark = 'hard'
let g:highlightedyank_highlight_duration = 500

if has('termguicolors')
set termguicolors
endif

nnoremap gd :YcmCompleter GoTo<CR>
nnoremap gs :YcmCompleter GoToSymbol<CR>
nnoremap gi :YcmCompleter GoToInclude<CR>
nnoremap gf :YcmCompleter GoToDefinition<CR>
nnoremap gc :YcmCompleter GoToDeclaration<CR>
nnoremap gr :YcmCompleter GoToReferences<CR>
nnoremap <F3> :YcmCompleter Format<CR>
nnoremap <leader>f :YcmCompleter FixIt<CR>

let g:ycm_clangd_binary_path='/usr/bin/clangd'
let g:ycm_clangd_args=['-header-insertion=never']
let g:ycm_always_populate_location_list=1
let g:ycm_disable_for_files_larger_than_kb = 0
let g:ycm_max_diagnostics_to_display = 0
let g:ycm_warning_symbol = '--'
let g:ycm_semantic_triggers =  {
  \   'c': ['->', '.'],
  \   'objc': ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
  \            're!\[.*\]\s'],
  \   'ocaml': ['.', '#'],
  \   'cpp,cuda,objcpp': ['->', '.', '::'],
  \   'perl': ['->'],
  \   'php': ['->', '::'],
  \   'cs,d,elixir,go,groovy,java,javascript,julia,perl6,python,scala,typescript,vb': ['.'],
  \   'ruby,rust': ['.', '::'],
  \   'lua': ['.', ':'],
  \   'erlang': [':'],
  \ }

set nocompatible
set mouse=a
set noshowmode
set path+=**
filetype on
filetype plugin on
set ignorecase
set smartcase
set showmatch
set wildmode=list:longest
set number
set rnu
syntax enable
set wildmenu
let mapleader=" "
set hidden
set cmdheight=1
set updatetime=200
set shortmess+=c
set signcolumn=yes " Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved.
set nobackup
set nowritebackup
set noswapfile
set clipboard=unnamedplus
noremap gl $
noremap gh 0
set cursorline
set splitbelow splitright

" netrw config
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_preview=1
let g:netrw_winsize=25
autocmd FileType netrw setl bufhidden=delete
nmap <leader><leader> :Vex<CR>
" open files from netrw in a previous window, unless we're opening the current dir
if argv(0) ==# '.'
    let g:netrw_browse_split = 0
else
    let g:netrw_browse_split = 4
endif

set encoding=UTF-8

nnoremap <c-Left> <c-w>h
nnoremap <c-Right> <c-w>l
nnoremap <c-Up> <c-w>k
nnoremap <c-Down> <c-w>j

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

set laststatus=2
set statusline=
set statusline+=%2*
set statusline+=%{StatuslineMode()}
set statusline+=%1*
set statusline+=\ 
set statusline+=<
set statusline+=<
set statusline+=\ 
set statusline+=%f
set statusline+=\ 
set statusline+=>
set statusline+=>
set statusline+=%=
set statusline+=%m
set statusline+=%h
set statusline+=%r
set statusline+=\ 
set statusline+=%3*
set statusline+=%{b:gitbranch}
set statusline+=%1*
set statusline+=\ 
set statusline+=%4*
set statusline+=%F
set statusline+=:
set statusline+=:
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

"========== GIT STUFF ======================================
" Change these if you want
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'

" I find the numbers disctracting
let g:signify_sign_show_count = 0
let g:signify_sign_show_text = 1

" Jump though hunks
nmap <leader>jj <plug>(signify-next-hunk)
nmap <leader>kk <plug>(signify-prev-hunk)

" If you like colors instead
" highlight SignifySignAdd                  ctermbg=green                guibg=#00ff00
" highlight SignifySignDelete ctermfg=black ctermbg=red    guifg=#ffffff guibg=#ff0000
" highlight SignifySignChange ctermfg=black ctermbg=yellow guifg=#000000 guibg=#ffff00
" ======================================================================================================

set is hlsearch
nmap <leader><CR> :nohlsearch<CR>
nnoremap j gj
nnoremap k gk
nnoremap <Up> gk
nnoremap <Down> gj
au VimEnter * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
au VimLeave * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'

"debugging shortcuts
nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>de :call vimspector#Reset()<CR>

nnoremap <leader>dtcb :call vimspector#CleanLineBreakpoint()<CR>

nmap <leader>dl <Plug>VimspectorStepInto
nmap <leader>dj <Plug>VimspectorStepOver
nmap <leader>dk <Plug>VimspectorStepOut
nmap <leader>d_ <Plug>VimspectorRestart
nnoremap <leader>d<space> :call vimspector#Continue()<CR>

nmap <leader>drc <Plug>VimspectorRunToCursor
nmap <leader>dbp <Plug>VimspectorToggleBreakpoint
nmap <leader>dcbp <Plug>VimspectorToggleConditionalBreakpoint

" terminal open
nmap <leader>t :ter<CR>

" buffer switching
nmap <leader>l :bn<CR>
nmap <leader>h :bp<CR>

" move around in insert mode
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

" run git status
nmap <leader>g :G<CR>

" write read-only file trick shortcut
command! -nargs=0 Sw w !sudo tee % > /dev/null
