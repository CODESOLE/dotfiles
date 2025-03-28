call plug#begin()
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'Donaldttt/fuzzyy',
Plug 'monkoose/vim9-stargate',
Plug 'puremourning/vimspector',
call plug#end()
packadd! editorconfig
packadd! comment
packadd! cfilter
set guicursor+=a:block,a:blinkoff0
set laststatus=- fillchars+=eob:\ 
set rulerformat=%100(%{coc#status()}%=%{get(g:,'coc_git_status','')}\ %{get(b:,'coc_git_status','')}\ %{get(b:,'coc_current_function','')}%)
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab smartindent
set ut=200
set nowrap
set list lcs=extends:>,precedes:<
nmap s <Cmd>call stargate#OKvim(2)<CR>
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
nmap <silent> <esc> :noh<CR>
vmap <leader>k :!curl -sF 'text=<-' vpaste.net<CR>
augroup auto_nohlsearch | au!
    noremap <Plug>(nohlsearch) <cmd>nohlsearch<cr>
    noremap! <expr> <Plug>(nohlsearch) execute('nohlsearch')[-1]
    au InsertEnter * call feedkeys("\<Plug>(nohlsearch)", 'm')
augroup END
set bg=dark
set termguicolors
set guifont=Hack\ Nerd\ Font\ Mono:h10
colorscheme retrobox
set gp=git\ grep\ -E
set backspace=2 ruler
set shortmess-=S
set shortmess+=I noshowcmd
set signcolumn=no noshowmode
set completeopt=menuone,popup,fuzzy,noselect completepopup=highlight:Pmenu
set wildmenu
set wildmode=list,full
set wildignore=*/builddir/*,*/build/*,tags,node_modules/*,.git/*,.cache/*,.clangd/*,target/*
syntax enable
set mouse=a
set is hlsearch ignorecase smartcase showmatch
set encoding=utf-8
set nobackup nowritebackup noswapfile
set guioptions=Ac
filetype on
filetype plugin on
let mapleader=" "
noremap gl $
noremap gh 0
nmap gn :bn<CR>
nmap gp :bp<CR>
vnoremap <leader>p "_dP
nnoremap <leader>l :cn<cr>
nnoremap <leader>h :cp<cr>
nnoremap <silent> <C-h> :tabn<CR>
tnoremap <silent> <C-h> <C-w>:tabn<CR>
nnoremap <silent> <CR> :tab term lazygit<CR>
nnoremap <silent> <C-t> :term<CR>
nnoremap <silent> <C-p> :tab term<CR>
nnoremap <silent> <leader>o :CocCommand explorer<cr>
nnoremap <silent> <leader>O :CocOutline<cr>
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
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
vnoremap ' :s/\%V\(.*\)\%V/'\1'/ <CR>
vnoremap ( :s/\%V\(.*\)\%V/\(\1\)/ <CR>
vnoremap ) :s/\%V\(.*\)\%V/\(\1\)/ <CR>
vnoremap { :s/\%V\(.*\)\%V/\{\1\}/ <CR>
vnoremap } :s/\%V\(.*\)\%V/\{\1\}/ <CR>
vnoremap [ :s/\%V\(.*\)\%V/\[\1\]/ <CR>
vnoremap ] :s/\%V\(.*\)\%V/\[\1\]/ <CR>
inoremap { {}<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap " ""<left>
inoremap ' ''<left>
hi CocSemTypeDerive        guifg=#ffff00
hi CocSemModDeprecated     guifg=#323437
hi CocSemTypeBuiltin       guifg=#e65e72
hi CocUnusedHighlight      guifg=#b2b2b2
hi CocSemTypeComment       guifg=#444444
hi CocSemTypeDecorator     guifg=#de935f
hi CocSemTypeClass         guifg=#36c692
hi CocSemTypeEnum          guifg=#fa81ef
hi CocSemTypeStruct        guifg=#36c692
hi CocSemTypeEnumMember    guifg=#ae81ff
hi CocSemTypeInterface     guifg=#cf87e8
hi CocSemTypeKeyword       guifg=#ff5454
hi CocSemTypeMacro         guifg=#ff5189
hi CocSemTypeMethod        guifg=#74b2ff
hi CocSemTypeFunction      guifg=#74b2ff
hi CocSemTypeModifier      guifg=#e3c78a
hi CocSemTypeType          guifg=#8cc85f
hi CocSemTypeTypeParameter guifg=#f09479
hi CocSemTypeVariable      guifg=#c6c6c6
hi CocSemTypeNamespace     guifg=#a744ab
hi CocSemTypeProperty      guifg=#adadf3
hi CocSemTypeParameter     guifg=#e196a2
hi CocSemTypeOperator      guifg=#80a0ff
hi CocSemTypeNumber        guifg=#79dac8
hi CocSemTypeString        guifg=#c6c684
hi CocSemTypeRegexp        guifg=#79dac8
hi CocSemTypeBoolean	     guifg=#FF0000
hi Normal guibg=#000000
hi CocSemTypeEvent guifg=#1E4F0A
hi CocInlayHint guibg=#080808 guifg=#444444
hi Cursor guibg=#FF4000
hi Pmenu guibg=#111111
hi NonText guibg=#999999
hi Tabline guibg=#050505
hi TablineFill guibg=#000000
hi TablineSel guibg=#111111
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
nmap <leader>F  :Format<CR>
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
	      let g:fuzzyy_enable_mappings = 0
              let g:fuzzyy_respect_gitignore = 1
              let g:fuzzyy_devicons = 0
	      nnoremap <silent><nowait> <space>ff  :FuzzyFiles<cr>
	      nnoremap <silent><nowait> <space>fg  :FuzzyGitFiles<cr>
	      nnoremap <silent><nowait> <space>fl  :FuzzyGrep<cr>
	      nnoremap <silent><nowait> <space>fc  :FuzzyInBuffer<cr>
	      nnoremap <silent><nowait> <space>fb  :FuzzyBuffers<cr>
	      nnoremap <silent><nowait> <space>fo  :FuzzyMru<cr>
	      " nnoremap <silent><nowait> <space>ff  :<C-u>CocList files<cr>
	      " nnoremap <silent><nowait> <space>fg  :<C-u>CocList gfiles<cr>
	      " nnoremap <silent><nowait> <space>fl  :<C-u>CocList grep<cr>
	      " nnoremap <silent><nowait> <space>fc  :<C-u>CocList lines<cr>
	      " nnoremap <silent><nowait> <space>fb  :<C-u>CocList buffers<cr>
	      " nnoremap <silent><nowait> <space>fo  :<C-u>CocList mru<cr>
	      nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
	      nnoremap <silent><nowait> <space>s  :<C-u>CocList outline<cr>
	      nnoremap <silent><nowait> <space>w  :<C-u>CocList -I symbols<cr>
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
