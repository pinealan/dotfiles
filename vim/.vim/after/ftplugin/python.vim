set cc=88

nnoremap <leader>d  :call ToggleDocstring()<cr>

function! ToggleDocstring()
    let hi = execute("highlight pythonDocString")
    if len(matchstr(hi, "cterm=bold")) == 0
        highlight pythonDocString cterm=bold
    else
        highlight pythonDocString cterm=None
    endif
endfunction
