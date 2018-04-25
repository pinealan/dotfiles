set nosmarttab
set tw=80

function! Underline(symbol)
    if strlen(getline('.')) > 0
        normal! yyp
        exe 's/./' . a:symbol . '/g'
        normal! k
    endif
endfunction

nnoremap - :call Underline('-')<cr>
nnoremap = :call Underline('=')<cr>
