setl tw=80
compiler clj-kondo

""" Functions {{{1

function! AltSrcTestPath()
    let root = expand('%:r')
    let ext = expand('%:e')
    if root =~# '^src'
        return substitute( root.'_test.','^src','test','' ).ext
    elseif root =~# '^test'
        return substitute( substitute( root,'_test$','.','' ),'^test','src','' ).ext
    else
        echom 'File path does not start with "src" or "test"'
        return expand('%')
    endif
endfunction

function! ToggleIcedIdent()
    if &indentexpr == ''
        set indentexpr=GetIcedIndent()
    elseif &indentexpr == 'GetIcedIndent()'
        set indentexpr=
    endif
endfunction

function! HighlightHiccup()
    " Tags
    for tag in [
        \ 'html', 'header', 'head', 'body', 'nav', 'aside', 'footer', 'main',
        \ 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'a', 'p', 'span', 'b', 'i',
        \ 'li', 'ul', 'ol', 'div', 'section', 'article', 'button', 'input',
        \ 'select', 'progress', 'form', 'img', 'strong', 'label'
    \]
        call matchadd('Identifier', '\[\zs:' .. tag .. '\ze\s')
        call matchadd('Identifier', '\[\zs:' .. tag .. '\ze\n')
    endfor

    " Attrs
    for attr in ['class', 'href', 'type', 'placeholder']
        call matchadd('Type', '\zs:' .. attr .. '\ze\s')
        call matchadd('Type', '\zs:' .. attr .. '\ze\n')
    endfor
endfunction

command! HighlightHiccup call HighlightHiccup()

let g:clj_trim_comma = 1

function! TrimComma()
    if (exists("b:clj_trim_comma") && b:clj_trim_comma != v:false) || g:clj_trim_comma != v:false
        %s/,$//e
    endif
endfunction

augroup usr
    autocmd BufWrite    *.clj,*.cljc,*.cljs call TrimComma()
augroup END


""" Sexp mappings {{{1

" Mappings to just wrap element and keep cursor at the same spot
nmap <buffer> <localleader>W(    m`<Plug>(sexp_round_head_wrap_element)g``
nmap <buffer> <localleader>W[    m`<Plug>(sexp_square_head_wrap_element)g``
nmap <buffer> <localleader>W{    m`<Plug>(sexp_curly_head_wrap_element)g``

" Mappings to just wrap list and keep cursor at the same spot
nmap <buffer> <localleader>WW(    m`<Plug>(sexp_round_head_wrap_list)g``
nmap <buffer> <localleader>WW[    m`<Plug>(sexp_square_head_wrap_list)g``
nmap <buffer> <localleader>WW{    m`<Plug>(sexp_curly_head_wrap_list)g``

" Mappings to wrap element + insert at start or end
nmap <buffer> <localleader>w(   <Plug>(sexp_round_head_wrap_element)a
nmap <buffer> <localleader>w)   <Plug>(sexp_round_tail_wrap_element)i
nmap <buffer> <localleader>w[   <Plug>(sexp_square_head_wrap_element)a
nmap <buffer> <localleader>w]   <Plug>(sexp_square_tail_wrap_element)i
nmap <buffer> <localleader>w{   <Plug>(sexp_curly_head_wrap_element)a
nmap <buffer> <localleader>w}   <Plug>(sexp_curly_tail_wrap_element)i

" Mappings to wrap list + insert at start or end
nmap <buffer> <localleader>ww(   <Plug>(sexp_round_head_wrap_list)a
nmap <buffer> <localleader>ww)   <Plug>(sexp_round_tail_wrap_list)i
nmap <buffer> <localleader>ww[   <Plug>(sexp_square_head_wrap_list)a
nmap <buffer> <localleader>ww]   <Plug>(sexp_square_tail_wrap_list)i
nmap <buffer> <localleader>ww{   <Plug>(sexp_curly_head_wrap_list)a
nmap <buffer> <localleader>ww}   <Plug>(sexp_curly_tail_wrap_list)i

" Duplicate alias for wrapping element + insert
nmap <buffer> <localleader>wi    <Plug>(sexp_round_head_wrap_element)a
nmap <buffer> <localleader>wa    <Plug>(sexp_round_tail_wrap_element)i

" Duplicate alias for wrapping list + insert
nmap <buffer> <localleader>wwi    <Plug>(sexp_round_head_wrap_list)a
nmap <buffer> <localleader>wwa    <Plug>(sexp_round_tail_wrap_list)i

nmap <buffer> <localleader>D    yaf%pi<cr><esc>

imap <buffer> <silent> <M-S-k>    <esc><Plug>(sexp_swap_list_backward)
imap <buffer> <silent> <M-S-j>    <esc><Plug>(sexp_swap_list_forward)
imap <buffer> <silent> <M-S-h>    <esc><Plug>(sexp_swap_element_backward)
imap <buffer> <silent> <M-S-l>    <esc><Plug>(sexp_swap_element_forward)


""" Iced mappings & configs {{{1

set keywordprg=:IcedDocumentPopupOpen

let g:iced_enable_clj_kondo_analysis = v:true
let g:iced_enable_clj_kondo_local_analysis = v:true
let g:iced_clj_kondo_analysis_dirs = ['src', 'dev', 'test']
let g:iced_formatter = 'zprint'
let g:iced#format#zprint_option = '{}'
let g:iced#nrepl#skip_evaluation_when_buffer_size_is_exceeded = v:true

" Normal whitespace-based word navigation
noremap <buffer>    <M-w> w
noremap <buffer>    <M-W> W
noremap <buffer>    <M-b> b
noremap <buffer>    <M-B> B
noremap <buffer>    <M-e> e
noremap <buffer>    <M-E> E

nmap <buffer> <localleader>'     <cmd>IcedConnect<cr>
nmap <buffer> <localleader>rr    <cmd>IcedRequire<cr><cmd>w<cr>
nmap <buffer> <localleader>ew    m`<Plug>(iced_eval)<Plug>(sexp_inner_element)g``
nmap <buffer> <localleader>ef    m`<Plug>(iced_eval)<Plug>(sexp_outer_list)g``
nmap <buffer> <localleader>ee    m`<Plug>(iced_eval_outer_top_list)g``

nmap <buffer> <localleader>er    m`<Plug>(iced_eval_and_replace)<Plug>(sexp_inner_element)g``
nmap <buffer> <localleader>eR    m`<Plug>(iced_eval_and_replace)<Plug>(sexp_outer_list)g``

nmap <buffer> <localleader>eW    m`<Plug>(iced_eval_and_print)<Plug>(sexp_inner_element)g``
nmap <buffer> <localleader>eF    m`<Plug>(iced_eval_and_print)<Plug>(sexp_outer_list)g``
nmap <buffer> <localleader>eE    m`<Plug>(iced_eval_outer_top_list)g``:IcedPrintLast<cr>

" Duplicate in case of fat finger fast typing
nmap <buffer> <localleader>EW    m`<Plug>(iced_eval_and_print)<Plug>(sexp_inner_element)g``
nmap <buffer> <localleader>EF    m`<Plug>(iced_eval_and_print)<Plug>(sexp_outer_list)g``
nmap <buffer> <localleader>EE    m`<Plug>(iced_eval_outer_top_list)g``:IcedPrintLast<cr>
nmap <buffer> <localleader>ER    m`<Plug>(iced_eval_and_replace)<Plug>(sexp_outer_list)g``

nmap <buffer> <localleader>eq       <cmd>IcedInterrupt<cr>
xmap <localleader>ee                <cmd>IcedEvalVisual<cr>

nmap <buffer> <localleader>l        <cmd>IcedPrintLast<cr>

" docs
nmap <buffer> <localleader>hc       <cmd>IcedClojureDocsOpen<cr>
nmap <buffer> <localleader>hd       <cmd>IcedDocumentOpen<cr>
nmap <buffer> <localleader>hq       <cmd>IcedDocumentClose<cr>
nmap <buffer> <localleader>hs       <cmd>IcedSourceShow<cr>
" Alias for open/close doc
nmap <buffer> <localleader>d        <cmd>IcedDocumentOpen<cr>
nmap <buffer> <localleader>q        <cmd>IcedDocumentClose<cr>

nmap <buffer> <localleader>jd       <cmd>IcedDefJump .<cr>
nmap <buffer> <localleader>jl       <cmd>IcedJumpToLet<cr>

" tap
nmap <buffer> <localleader>tb       <cmd>IcedBrowseTapped
nmap <buffer> <localLeader>tc       <cmd>IcedClearTapped<cr>
nmap <buffer> <localleader>td       <cmd>IcedDeleteTapped<cr>

" test
nmap <buffer> <localleader>tt       <cmd>IcedTestUnderCursor<cr>
nmap <buffer> <localLeader>tn       <cmd>IcedTestNs<cr>
nmap <buffer> <localleader>tr       <cmd>IcedTestRedo<cr>
nmap <buffer> <localLeader>tl       <cmd>IcedTestRerunLast<cr>

nmap <buffer> <localLeader>ss       :IcedCljsRepl (figwheel.main.api/repl-env "dev")
nmap <buffer> <localLeader>sc       <cmd>IcedCycleSession<cr>
nmap <buffer> <localLeader>sq       <cmd>IcedQuitCljsRepl<cr>

nmap <buffer> <localLeader>sp       i)()<esc>x2<Plug>(sexp_flow_to_prev_close)J%lywh%a<cr><esc>p
nmap <buffer> <localLeader>si       i)()<esc>x

" refactor
nmap <buffer> <localleader>ra       <cmd>IcedAddArity<cr>
nmap <buffer> <localLeader>rc       <cmd>IcedCleanNs<cr>
nmap <buffer> <localLeader>ri       <cmd>IcedAddMissing<cr>
nmap <buffer> <localLeader>rn       <cmd>IcedAddNs<cr>
nmap <buffer> <localLeader>rs       <cmd>IcedRenameSymbol<cr>

nmap <buffer> <localleader>re       <cmd>IcedExtractFunction<cr>
nmap <buffer> <localleader>rm       <cmd>IcedMoveToLet<cr>

nmap <buffer> <localleader>rf       <cmd>IcedThreadFirst<cr>
nmap <buffer> <localleader>rl       <cmd>IcedThreadLast<cr>

" Keyword to string and vice versa
" Leverage binding of vim-sexp and vim-surround
nmap <buffer> <localleader>K        ds"i:<esc>
nmap <buffer> <localleader>S        wbxysiw"

" iced buffer
nmap <buffer> <localleader>bb       <cmd>IcedStdoutBufferOpen<cr>
nmap <buffer> <localleader>bc       <cmd>IcedStdoutBufferClear<cr>
nmap <buffer> <localleader>be       <cmd>IcedEval *e<cr>:IcedPrintLast<cr>
nmap <buffer> <localleader>bl       <cmd>IcedPrintLast<cr>
nmap <buffer> <localleader>bq       <cmd>IcedStdoutBufferClose<cr>
nmap <buffer> <localleader>bt       <cmd>IcedTestBufferOpen<cr>

" lookup usage
nmap <buffer> <localleader>bd       <cmd>IcedBrowseDependencies<cr>
nmap <buffer> <localleader>br       <cmd>IcedBrowseReferences<cr>

nmap <buffer> <localleader>vc       <cmd>IcedEval {:vlaaad.reveal/command '(clear-output)}<cr>

nmap <buffer> <localleader>==       <cmd>IcedFormat<cr>
nmap <buffer> <localleader>=G       <cmd>IcedFormatAll<cr>


""" Other mappings {{{1

nmap <buffer> <localleader><Tab>    :edit <C-R>=AltSrcTestPath()<cr><cr>
nmap <buffer> <localleader>m        <cmd>lmake<cr>
