setl cc=89
setl tw=88

command! -nargs=* PythonGoto YcmCompleter GoTo

set keywordprg=:PythonGoto

function! AltSrcTestPath()
    let head = expand('%:h')
    let tail = expand('%:t')
    if head =~# '^src'
        return substitute( head . '/test_' . tail,'^src','test','' )
    elseif head =~# '^test'
        return substitute( head . substitute( tail,'^test_','/','' ) ,'^test','src','' )
    else
        echom 'File path does not start with "src" or "test"'
        return expand('%')
endfunction

function! ToggleDocstring()
    let l:hi = execute("highlight pythonDocString")
    if len(matchstr(l:hi, "cterm=bold")) == 0
        highlight pythonDocString cterm=bold
    else
        highlight pythonDocString cterm=None
    endif
endfunction

"nmap <localleader>k  :vimgrep /^ *class/g @%
nmap <localleader>d  :call ToggleDocstring()<cr>
nmap <localleader>b  :!black %<cr>

nmap <localleader><Tab>     :edit <C-R>=AltSrcTestPath()<cr><cr>

hi link @attribute          Special
hi link @constructor        Normal
hi link @field              Normal
hi link @variable           Normal
hi link @variable.builtin   Special

nnoremap <localleader>np    :call jukit#convert#notebook_convert("jupyter-notebook")<cr>
nnoremap <localleader>'     :call jukit#splits#output()<cr>
nnoremap <localleader>bb    :call jukit#splits#history()<cr>
nnoremap <localleader>ee    :call jukit#send#section(0)<cr>
nnoremap <localleader>ef    :call jukit#send#line()<cr>

nnoremap <localleader>cj    :call jukit#cells#create_below(0)<cr>
nnoremap <localleader>ck    :call jukit#cells#create_above(0)<cr>
nnoremap <localleader>cJ    :call jukit#cells#create_below(1)<cr>
nnoremap <localleader>cK    :call jukit#cells#create_above(1)<cr>
nnoremap <localleader>cd    :call jukit#cells#delete()<cr>
nnoremap <localleader>cs    :call jukit#cells#split()<cr>
nnoremap <localleader>cm    :call jukit#cells#merge_below()<cr>
nnoremap <localleader>cM    :call jukit#cells#merge_above()<cr>

nnoremap <localleader>J     :call jukit#cells#move_down()<cr>
nnoremap <localleader>K     :call jukit#cells#move_up()<cr>

nnoremap <localleader>j     :call jukit#cells#jump_to_next_cell()<cr>
nnoremap <localleader>k     :call jukit#cells#jump_to_previous_cell()<cr>
