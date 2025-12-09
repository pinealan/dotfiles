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

" doing my own mappings because the defaults uses <Leader> or <M-*>
"
let g:sexp_enable_insert_mode_mappings = 0
let g:sexp_insert_after_wrap = 0
let g:sexp_mappings = {
    \ 'sexp_outer_list':                'af',
    \ 'sexp_inner_list':                'if',
    \ 'sexp_outer_top_list':            'at',
    \ 'sexp_inner_top_list':            'it',
    \ 'sexp_outer_string':              'as',
    \ 'sexp_inner_string':              'is',
    \ 'sexp_outer_element':             'ae',
    \ 'sexp_inner_element':             'ie',
    \ 'sexp_flow_to_prev_open':         '(',
    \ 'sexp_flow_to_next_open':         ')',
    \ 'sexp_flow_to_prev_close':        '',
    \ 'sexp_flow_to_next_close':        '',
    \ 'sexp_flow_to_prev_leaf_head':    'b',
    \ 'sexp_flow_to_next_leaf_head':    'w',
    \ 'sexp_flow_to_prev_leaf_tail':    '',
    \ 'sexp_flow_to_next_leaf_tail':    'e',
    \ 'sexp_move_to_prev_bracket':      '[f',
    \ 'sexp_move_to_next_bracket':      ']f',
    \ 'sexp_move_to_prev_element_head': 'B',
    \ 'sexp_move_to_next_element_head': 'W',
    \ 'sexp_move_to_prev_element_tail': 'gE',
    \ 'sexp_move_to_next_element_tail': 'E',
    \ 'sexp_move_to_prev_top_element':  '[[',
    \ 'sexp_move_to_next_top_element':  ']]',
    \ 'sexp_select_prev_element':       '[e',
    \ 'sexp_select_next_element':       ']e',
    \ 'sexp_indent':                    '',
    \ 'sexp_indent_top':                '',
    \ 'sexp_round_head_wrap_list':      '',
    \ 'sexp_round_tail_wrap_list':      '',
    \ 'sexp_square_head_wrap_list':     '',
    \ 'sexp_square_tail_wrap_list':     '',
    \ 'sexp_curly_head_wrap_list':      '',
    \ 'sexp_curly_tail_wrap_list':      '',
    \ 'sexp_round_head_wrap_element':   '',
    \ 'sexp_round_tail_wrap_element':   '',
    \ 'sexp_square_head_wrap_element':  '',
    \ 'sexp_square_tail_wrap_element':  '',
    \ 'sexp_curly_head_wrap_element':   '',
    \ 'sexp_curly_tail_wrap_element':   '',
    \ 'sexp_insert_at_list_head':       '<localleader>i',
    \ 'sexp_insert_at_list_tail':       '<localleader>a',
    \ 'sexp_splice_list':               '<localleader>p',
    \ 'sexp_convolute':                 '<localleader>c',
    \ 'sexp_raise_list':                '<localleader>O',
    \ 'sexp_raise_element':             '<localleader>o',
    \ 'sexp_swap_list_backward':        '<M-S-k>',
    \ 'sexp_swap_list_forward':         '<M-S-j>',
    \ 'sexp_swap_element_backward':     '<M-S-h>',
    \ 'sexp_swap_element_forward':      '<M-S-l>',
    \ 'sexp_emit_head_element':         '><',
    \ 'sexp_emit_tail_element':         '<>',
    \ 'sexp_capture_prev_element':      '<<',
    \ 'sexp_capture_next_element':      '>>',
    \ }

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

nmap <buffer> <localleader><Tab>    :edit <C-R>=AltSrcTestPath()<cr><cr>
nmap <buffer> <localleader>m        <cmd>lmake<cr>

""" WhichKey {{{1

let g:localleader_map = {}

let g:localleader_map["'"] = 'Iced connect'
let g:localleader_map['a'] = 'Sexp insert at tail'
let g:localleader_map['c'] = 'Sexp convolute'
let g:localleader_map['d'] = 'Iced document open'
let g:localleader_map['q'] = 'Iced document close'
let g:localleader_map['i'] = 'Sexp insert at head'
let g:localleader_map['m'] = 'Run :lmake'
let g:localleader_map['l'] = 'Iced print last'
let g:localleader_map['o'] = 'Sexp raise element'
let g:localleader_map['D'] = 'Sexp duplicate'
let g:localleader_map['O'] = 'Sexp raise list'
let g:localleader_map['p'] = 'Sexp splice'

let g:localleader_map['e'] = {
    \ 'name': '+iced-eval',
    \ 'e': 'Eval top list',
    \ 'f': 'Eval list',
    \ 'w': 'Eval element',
    \ 'E': 'Eval & print top list',
    \ 'F': 'Eval & print list',
    \ 'W': 'Eval & print element',
    \ }

let g:localleader_map['E'] = {
    \ 'name': '+iced-eval-print',
    \ 'E': 'Eval & print top list',
    \ 'F': 'Eval & print list',
    \ 'W': 'Eval & print element',
    \ }

let g:localleader_map['='] = { 'name': '+iced-format' }

let g:localleader_map['b'] = {
    \ 'name': '+iced-buffers/browse',
    \ 'd': 'Browse dependencies',
    \ 'r': 'Browse references',
    \ 'e': 'Print last error',
    \ 'l': 'Print last result',
    \ }

let g:localleader_map['h'] = { 'name': '+iced-docs' }
let g:localleader_map['j'] = { 'name': '+iced-jump' }

let g:localleader_map['s'] = {
    \ 'name': '+iced-cljs/split',
    \ 'i': 'Split list',
    \ 'p': 'Split list and copy first leaf',
    \ }

let g:localleader_map['t'] = { 'name': '+iced-tap/test' }

let g:localleader_map['r'] = {
    \ 'name': '+iced-refactor',
    \ 'a': 'Add arity',
    \ 'c': 'Clean ns form',
    \ 'e': 'Extract to function',
    \ 'm': 'Move to let',
    \ 'n': 'Add namespace',
    \ 's': 'Rename symbol',
    \ 'r': 'Require',
    \ 'f': 'Thread first',
    \ 'l': 'Thread last',
    \ }

let g:localleader_map['v'] = {
    \ 'name': '+vlaaad.reveal',
    \ 'c': 'Clear reveal output',
    \ }

let g:localleader_map['w'] = {
    \ 'name': '+sexp-wrap-insert',
    \ 'i': 'Wrap element in parens & insert',
    \ 'a': 'Wrap element in parens & append',
    \ '(': 'Wrap element in parens & insert',
    \ ')': 'Wrap element in parens & append',
    \ '[': 'Wrap element in brackets & insert',
    \ ']': 'Wrap element in brackets & append',
    \ '{': 'Wrap element in braces & insert',
    \ '}': 'Wrap element in braces & append',
    \ 'w': {
    \     'name': '+for-list',
    \     'i': 'Wrap list in parens & insert',
    \     'a': 'Wrap list in parens & append',
    \     '(': 'Wrap list in parens & insert',
    \     ')': 'Wrap list in parens & append',
    \     '[': 'Wrap list in brackets & insert',
    \     ']': 'Wrap list in brackets & append',
    \     '{': 'Wrap list in braces & insert',
    \     '}': 'Wrap list in braces & append',
    \     },
    \ }

let g:localleader_map['W'] = {
    \ 'name': '+sexp-wrap-only',
    \ '(': 'Wrap element in parens',
    \ '[': 'Wrap element in brackets',
    \ '{': 'Wrap element in braces',
    \ 'W': {
    \     'name': '+for-list',
    \     '(': 'Wrap list in parens',
    \     '[': 'Wrap list in brackets',
    \     '{': 'Wrap list in braces',
    \     },
    \ }

let g:localleader_map['<Tab>'] = "Goto corresponding src/test file"

call which_key#register("'", "g:localleader_map")
nnoremap <buffer> <silent> <localleader>     <cmd>WhichKey "'"<CR>
vnoremap <buffer> <silent> <localleader>     <cmd>WhichKeyVisual "'"<CR>

let b:AutoPairs = {'(':')', '[':']', '{':'}', '"':'"'}

setl tw=80
compiler clj-kondo
