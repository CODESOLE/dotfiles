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
set fillchars+=eob:\ 
