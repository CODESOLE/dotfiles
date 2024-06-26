call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'puremourning/vimspector'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
call plug#end()
nnoremap s <Plug>(easymotion-s2)
colorscheme retrobox
set gp=git\ grep\ -rn
set shortmess+=I
set signcolumn=no
set noshowcmd
set noshowmode
set noruler
set updatetime=200
set laststatus=-
set wildmode=list,full
set wildignore=*/builddir/*,*/build/*,tags,node_modules/*,.git/*,.cache/*,.clangd/*,target/*
set path+=**
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab
syntax enable
filetype on
filetype plugin on
set ignorecase
set smartcase
set showmatch
let mapleader=" "
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
nmap <silent> <leader><CR> :nohlsearch<CR>
nmap gn :bn<CR>
nmap gp :bp<CR>
nnoremap <leader>l :cn<cr>
nnoremap <leader>h :cp<cr>
nnoremap <leader>o :CocOutline<cr>
nnoremap <leader>O :ccl<cr>
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
set nobackup
set nowritebackup
set noswapfile
inoremap <silent> ş <Esc>:nohlsearch<cr>
vnoremap <silent> ş <Esc>:nohlsearch<cr>
cnoremap <silent> ş <Esc>:nohlsearch<cr>
hi CocInlayHint guibg=#111111 guifg=#444444
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
            \ CheckBackspace() ? "\<Tab>" :
	          \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
function! CheckBackspace() abort
	  let col = col('.') - 1
	    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
if has('nvim')
	  inoremap <silent><expr> <c-space> coc#refresh()
else
	  inoremap <silent><expr> <c-@> coc#refresh()
endif
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gs :CocCommand clangd.switchSourceHeader<CR>
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
	  if CocAction('hasProvider', 'hover')
		      call CocActionAsync('doHover')
		        else
				    call feedkeys('K', 'in')
				      endif
endfunction
autocmd CursorHold * silent call CocActionAsync('highlight')
nmap <leader>rn <Plug>(coc-rename)
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
augroup mygroup
	  autocmd!
	    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
	      augroup end
	      xmap <leader>a  <Plug>(coc-codeaction-selected)
	      nmap <leader>a  <Plug>(coc-codeaction-selected)
	      nmap <leader>ac  <Plug>(coc-codeaction-cursor)
	      nmap <leader>as  <Plug>(coc-codeaction-source)
	      nmap <leader>qf  <Plug>(coc-fix-current)
	      nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
	      xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
	      nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
	      nmap <leader>cl  <Plug>(coc-codelens-action)
	      xmap if <Plug>(coc-funcobj-i)
	      omap if <Plug>(coc-funcobj-i)
	      xmap af <Plug>(coc-funcobj-a)
	      omap af <Plug>(coc-funcobj-a)
	      xmap ic <Plug>(coc-classobj-i)
	      omap ic <Plug>(coc-classobj-i)
	      xmap ac <Plug>(coc-classobj-a)
	      omap ac <Plug>(coc-classobj-a)
	      if has('nvim-0.4.0') || has('patch-8.2.0750')
		        nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
			  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
			    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
			      inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
			        vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
				  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
	      endif
	      nmap <silent> <C-s> <Plug>(coc-range-select)
	      xmap <silent> <C-s> <Plug>(coc-range-select)
	      command! -nargs=0 Format :call CocActionAsync('format')
	      command! -nargs=? Fold :call     CocAction('fold', <f-args>)
	      command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
	      nnoremap <silent><nowait> <space>e  :<C-u>CocList diagnostics<cr>
	      nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
	      nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
	      nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
	      nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
nnoremap <Leader>dr <Plug>VimspectorRestart
nnoremap <Leader>de <Plug>VimspectorStop
nnoremap <Leader>dc <Plug>VimspectorContinue
nnoremap <Leader>dt <Plug>VimspectorRunToCursor
nnoremap <Leader>db :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Leader>dl <Plug>VimspectorToggleConditionalBreakpoint
nnoremap <Leader><Up> <Plug>VimspectorUpFrame
nnoremap <Leader><Down> <Plug>VimspectorDownFrame
nnoremap <Leader>dh <Plug>VimspectorStepOut
nnoremap <Leader>dk <Plug>VimspectorStepInto
nnoremap <Leader>dj <Plug>VimspectorStepOver
nnoremap <Leader>dp <Plug>VimspectorBalloonEval
vnoremap <Leader>dp <Plug>VimspectorBalloonEval
nnoremap <Leader>B <Plug>VimspectorBreakpoints
