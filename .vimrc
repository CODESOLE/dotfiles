call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'puremourning/vimspector'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'mg979/vim-visual-multi'
Plug 'jiangmiao/auto-pairs'
Plug 'Donaldttt/fuzzyy'
Plug 'voldikss/vim-floaterm'
Plug 'habamax/vim-dir'
Plug 'wellle/context.vim'
Plug 'bluz71/vim-moonfly-colors'
call plug#end()
set laststatus=-
set rulerformat=%150(%f\ %m\ %r\ %l:%L/%c\ %{coc#status()}%=%{get(g:,'coc_git_status','')}\ %{get(b:,'coc_git_status','')}%)
set guicursor+=a:block,a:blinkoff0
packadd! editorconfig
packadd! comment
packadd! cfilter
let g:EasyMotion_smartcase = 1
nmap s <Plug>(easymotion-overwin-f2)
set bg=dark
set termguicolors
set guifont=Hack\ Nerd\ Font\ Mono:h10
colorscheme moonfly
set gp=git\ grep\ -rn
set backspace=2 ruler
set shortmess-=S
set signcolumn=no
set completeopt=menuone,popup,fuzzy,noselect completepopup=highlight:Pmenu
set wildmenu
set wildmode=list,full
set wildignore=*/builddir/*,*/build/*,tags,node_modules/*,.git/*,.cache/*,.clangd/*,target/*
set path+=**
syntax enable
set mouse=a
set is hlsearch ignorecase smartcase showmatch
set encoding=utf-8
set nobackup
set nowritebackup
set noswapfile
set guioptions=Ac
filetype on
filetype plugin on
let mapleader=" "
noremap gl $
noremap gh 0
nmap gn :bn<CR>
nmap gp :bp<CR>
nnoremap <leader>l :cn<cr>
nnoremap <leader>h :cp<cr>
nnoremap <CR> :FloatermNew --height=0.9 --width=0.9 --wintype=float --name=floaterm1 --position=center --autoclose=2 lazygit<CR>
tnoremap <C-s> <C-\><C-n>
tnoremap <C-d> <C-\><C-n>:FloatermKill<CR>
tnoremap <C-y> <C-\><C-n>:FloatermNew<CR>
nnoremap <C-t> :FloatermToggle<CR>
tnoremap <C-t> <C-\><C-n>:FloatermToggle<CR>
tnoremap <C-j> <C-\><C-n>:FloatermNext<CR>
tnoremap <C-k> <C-\><C-n>:FloatermPrev<CR>
nnoremap <leader>o :Dir<cr>
nnoremap <leader>O :CocOutline<cr>
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
let g:enable_fuzzyy_MRU_files=1
let g:enable_fuzzyy_keymaps=0
nnoremap <silent> <leader>fi :FuzzyCommands<CR>
nnoremap <silent> <leader>ff :FuzzyFiles<CR>
nnoremap <silent> <leader>fl :FuzzyGrep<CR>
nnoremap <silent> <leader>fg :FuzzyGitFiles<CR>
nnoremap <silent> <leader>fb :FuzzyBuffers<CR>
nnoremap <silent> <leader>fo :FuzzyMRUFiles<CR>
nnoremap <silent> <leader>fc :FuzzyInBuffer<CR>
inoremap <silent> ş <Esc>
vnoremap <silent> ş <Esc>
cnoremap <silent> ş <Esc>
nnoremap [h <Plug>(coc-git-prevchunk)
nnoremap ]h <Plug>(coc-git-nextchunk)
nnoremap [c <Plug>(coc-git-prevconflict)
nnoremap ]c <Plug>(coc-git-nextconflict)
nnoremap <leader>u <Plug>(coc-git-keepcurrent)
nnoremap <leader>t <Plug>(coc-git-keepincoming)
nnoremap <leader>b <Plug>(coc-git-keepboth)
nnoremap <leader>g <Plug>(coc-git-chunkinfo)
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
