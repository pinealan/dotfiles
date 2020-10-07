setl cc=89
setl tw=88

command! -nargs=* PythonGoto YcmCompleter GoTo

set keywordprg=:PythonGoto

function! ToggleDocstring()
    let l:hi = execute("highlight pythonDocString")
    if len(matchstr(l:hi, "cterm=bold")) == 0
        highlight pythonDocString cterm=bold
    else
        highlight pythonDocString cterm=None
    endif
endfunction

nnoremap <localleader>k  :vimgrep /^ *class/g @%
nnoremap <localleader>d  :call ToggleDocstring()<cr>
nnoremap <localleader>b  :!black %<cr>
