setl cc=89
setl tw=88

nnoremap <localleader>k  :vimgrep /^ *class/g @%
nnoremap <localleader>d  :call ToggleDocstring()<cr>
nnoremap <localleader>b  :!black %<cr>

function! ToggleDocstring()
    let l:hi = execute("highlight pythonDocString")
    if len(matchstr(l:hi, "cterm=bold")) == 0
        highlight pythonDocString cterm=bold
    else
        highlight pythonDocString cterm=None
    endif
endfunction
