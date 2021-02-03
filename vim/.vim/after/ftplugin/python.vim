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

nmap <localleader>k  :vimgrep /^ *class/g @%
nmap <localleader>d  :call ToggleDocstring()<cr>
nmap <localleader>b  :!black %<cr>

nmap <localleader><Tab>     :edit <C-R>=AltSrcTestPath()<cr><cr>

function! AltSrcTestPath()
    let root = expand('%:r')
    if root !~# '^test'
        return substitute( root.'_test','^[^/]+/','test','' ).'.py'
    elseif root =~# '^test'
        return substitute( substitute( root,'/test_','/','' ),'^test/','','' ).'.py'
    else
        echom 'File path does not start with "src" or "test"'
        return expand('%')
endfunction
