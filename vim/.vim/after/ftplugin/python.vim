setl cc=89
setl tw=88

nnoremap <localleader>k  :vimgrep /^ *class/g @%
nnoremap <localleader>d  :call ToggleDocstring()<cr>

function! ToggleDocstring()
    let hi = execute("highlight pythonDocString")
    if len(matchstr(hi, "cterm=bold")) == 0
        highlight pythonDocString cterm=bold
    else
        highlight pythonDocString cterm=None
    endif
endfunction
