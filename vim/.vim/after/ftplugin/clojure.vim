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
endfunction

function! ToggleIcedIdent()
    if &indentexpr == ''
        set indentexpr=GetIcedIndent()
    elseif &indentexpr == 'GetIcedIndent()'
        set indentexpr=
endfunction

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
    \ 'sexp_flow_to_prev_close':        '{',
    \ 'sexp_flow_to_next_close':        '}',
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
    \ 'sexp_swap_list_backward':        '<M-Up>',
    \ 'sexp_swap_list_forward':         '<M-Down>',
    \ 'sexp_swap_element_backward':     '<M-Left>',
    \ 'sexp_swap_element_forward':      '<M-Right>',
    \ 'sexp_emit_head_element':         '><',
    \ 'sexp_emit_tail_element':         '<>',
    \ 'sexp_capture_prev_element':      '<<',
    \ 'sexp_capture_next_element':      '>>',
    \ }

" Mappings to just wrap element and keep cursor at the same spot
nmap <localleader>w(    m`<Plug>(sexp_round_head_wrap_element)g``
nmap <localleader>w[    m`<Plug>(sexp_square_head_wrap_element)g``
nmap <localleader>w{    m`<Plug>(sexp_curly_head_wrap_element)g``

" Mappings to just wrap list and keep cursor at the same spot
nmap <localleader>W(    m`<Plug>(sexp_round_head_wrap_list)g``
nmap <localleader>W[    m`<Plug>(sexp_square_head_wrap_list)g``
nmap <localleader>W{    m`<Plug>(sexp_curly_head_wrap_list)g``

" Duplicate alias for wrapping element + insert
nmap <localleader>wi    <Plug>(sexp_round_head_wrap_element)a
nmap <localleader>wa    <Plug>(sexp_round_tail_wrap_element)i

" Mappings to wrap element + insert
nmap <localleader>ww(   <Plug>(sexp_round_head_wrap_element)a
nmap <localleader>ww)   <Plug>(sexp_round_tail_wrap_element)i
nmap <localleader>ww[   <Plug>(sexp_square_head_wrap_element)a
nmap <localleader>ww]   <Plug>(sexp_square_tail_wrap_element)i
nmap <localleader>ww{   <Plug>(sexp_curly_head_wrap_element)a
nmap <localleader>ww}   <Plug>(sexp_curly_tail_wrap_element)i

" Mappings to wrap list + insert
nmap <localleader>WW(   <Plug>(sexp_round_head_wrap_list)a
nmap <localleader>WW)   <Plug>(sexp_round_tail_wrap_list)i
nmap <localleader>WW[   <Plug>(sexp_square_head_wrap_list)a
nmap <localleader>WW]   <Plug>(sexp_square_tail_wrap_list)i
nmap <localleader>WW{   <Plug>(sexp_curly_head_wrap_list)a
nmap <localleader>WW}   <Plug>(sexp_curly_tail_wrap_list)i

nmap <localleader>D    yaf%pi<cr><esc>

""" Iced mappings & configs {{{1

set keywordprg=:IcedDocumentPopupOpen

let g:iced_enable_clj_kondo_analysis = v:true
let g:iced_enable_clj_kondo_local_analysis = v:true
let g:iced_clj_kondo_analysis_dirs = ['src', 'dev', 'test']
let g:iced_formatter = 'zprint'
let g:iced#format#zprint_option = '{}'
let g:iced#nrepl#skip_evaluation_when_buffer_size_is_exceeded = v:true

" Normal whitespace-based word navigation
" nnoremap <buffer>       W w
" xnoremap <buffer>       W w
" nnoremap <buffer>       B b
" xnoremap <buffer>       B b
" nnoremap <buffer>       E e
" xnoremap <buffer>       E e

nmap <localleader>'     :IcedConnect<cr>
nmap <localleader>rr    :IcedRequire<cr>
nmap <localleader>ew    m`<Plug>(iced_eval)<Plug>(sexp_inner_element)g``
nmap <localleader>ef    m`<Plug>(iced_eval)<Plug>(sexp_outer_list)g``
nmap <localleader>ee    m`<Plug>(iced_eval_outer_top_list)g``

nmap <localleader>er    m`<Plug>(iced_eval_and_replace)<Plug>(sexp_inner_element)g``
nmap <localleader>eR    m`<Plug>(iced_eval_and_replace)<Plug>(sexp_outer_list)g``

nmap <localleader>eW    m`<Plug>(iced_eval_and_print)<Plug>(sexp_inner_element)g``
nmap <localleader>eF    m`<Plug>(iced_eval_and_print)<Plug>(sexp_outer_list)g``
nmap <localleader>eE    m`<Plug>(iced_eval_outer_top_list)g``:IcedPrintLast<cr>

" Duplicate in case of fat finger fast typing
nmap <localleader>EW    m`<Plug>(iced_eval_and_print)<Plug>(sexp_inner_element)g``
nmap <localleader>EF    m`<Plug>(iced_eval_and_print)<Plug>(sexp_outer_list)g``
nmap <localleader>EE    m`<Plug>(iced_eval_outer_top_list)g``:IcedPrintLast<cr>
nmap <localleader>ER    m`<Plug>(iced_eval_and_replace)<Plug>(sexp_outer_list)g``

nmap <localleader>eq    :IcedInterrupt<cr>
xmap <localleader>ee    :IcedEvalVisual<cr>

nmap <localleader>l     :IcedPrintLast<cr>

" docs
nmap <localleader>hc    :IcedClojureDocsOpen<cr>
nmap <localleader>hd    :IcedDocumentOpen<cr>
nmap <localleader>hq    :IcedDocumentClose<cr>
nmap <localleader>hs    :IcedSourceShow<cr>
" Alias for open/close doc
nmap <localleader>d     :IcedDocumentOpen<cr>
nmap <localleader>q     :IcedDocumentClose<cr>

nmap <localleader>jd    :IcedDefJump .<cr>
nmap <localleader>jl    :IcedJumpToLet<cr>

" tap
nmap <localleader>tb    :IcedBrowseTapped
nmap <localLeader>tc    :IcedClearTapped<cr>
nmap <localleader>td    :IcedDeleteTapped<cr>

" test
nmap <localleader>tt    :IcedTestUnderCursor<cr>
nmap <localLeader>tn    :IcedTestNs<cr>
nmap <localleader>tr    :IcedTestRedo<cr>
nmap <localLeader>tl    :IcedTestRerunLast<cr>

nmap <localLeader>ss    :IcedCljsRepl (figwheel.main.api/repl-env "dev")
nmap <localLeader>sc    :IcedCycleSession<cr>
nmap <localLeader>sq    :IcedQuitCljsRepl<cr>

nmap <localLeader>sp    i)()<esc>x2<Plug>(sexp_flow_to_prev_close)J%lywh%a<cr><esc>p
nmap <localLeader>si    i)()<esc>x

" refactor
nmap <localleader>raa   :IcedAddArity<cr>
nmap <localLeader>ram   :IcedAddMissing<cr>
nmap <localLeader>ran   :IcedAddNs<cr>
nmap <localLeader>rcn   :IcedCleanNs<cr>
nmap <localLeader>rs    :IcedRenameSymbol<cr>
nmap <localleader>rtf   :IcedThreadFirst<cr>
nmap <localleader>rtl   :IcedThreadLast<cr>
nmap <localleader>ref   :IcedExtractFunction<cr>
nmap <localleader>rml   :IcedMoveToLet<cr>

" iced buffer
nmap <localleader>bb    :IcedStdoutBufferOpen<cr>
nmap <localleader>bc    :IcedStdoutBufferClear<cr>
nmap <localleader>be    :IcedEval *e<cr>:IcedPrintLast<cr>
nmap <localleader>bl    :IcedPrintLast<cr>
nmap <localleader>bq    :IcedStdoutBufferClose<cr>
nmap <localleader>bt    :IcedTestBufferOpen<cr>

" lookup usage
nmap <localleader>bd    :IcedBrowseDependencies<cr>
nmap <localleader>br    :IcedBrowseReferences<cr>

nmap <localleader>vc    :IcedEval {:vlaaad.reveal/command '(clear-output)}<cr>

nmap <localleader>==    :IcedFormat<cr>
nmap <localleader>=G    :IcedFormatAll<cr>

nmap <localleader><Tab>     :edit <C-R>=AltSrcTestPath()<cr><cr>

""" WhichKey {{{1

let g:localleader_map = {}

let g:localleader_map['a'] = 'Sexp insert at tail'
let g:localleader_map['c'] = 'Sexp convolute'
let g:localleader_map['d'] = 'Iced document open'
let g:localleader_map['q'] = 'Iced document close'
let g:localleader_map['i'] = 'Sexp insert at head'
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
    \ 'a': {'name': '+add'},
    \ 'c': {'name': '+clean'},
    \ 'e': {'name': '+extract'},
    \ 'm': {'name': '+move'},
    \ 'r': {'name': '+rename'},
    \ 't': {'name': '+thread'},
    \ }

let g:localleader_map['v'] = {
    \ 'name': '+vlaaad.reveal',
    \ 'c': 'Clear reveal output',
    \ }

let g:localleader_map['w'] = {
    \ 'name': '+sexp-wrap-element',
    \ '(': 'In parens',
    \ '[': 'In brackets',
    \ '{': 'In braces',
    \ 'i': 'In parens & start insert at head',
    \ 'a': 'In parens & start insert at tail',
    \ 'w': {
    \     'name': '+wrap-and-insert',
    \     '(': 'In parens & start insert at head',
    \     ')': 'In parens & start insert at tail',
    \     '[': 'In brackets & start insert at head',
    \     ']': 'In brackets & start insert at tail',
    \     '{': 'In braces & start insert at head',
    \     '}': 'In braces & start insert at tail',
    \     },
    \ }

let g:localleader_map['W'] = {
    \ 'name': '+sexp-wrap-list',
    \ '(': 'In parens',
    \ '[': 'In brackets',
    \ '{': 'In braces',
    \ 'W': {
    \     'name': '+wrap-and-insert',
    \     '(': 'In parens & start insert at head',
    \     ')': 'In parens & start insert at tail',
    \     '[': 'In brackets & start insert at head',
    \     ']': 'In brackets & start insert at tail',
    \     '{': 'In braces & start insert at head',
    \     '}': 'In braces & start insert at tail',
    \     },
    \ }

let g:localleader_map['<Tab>'] = "Goto corresponding src/test file"

call which_key#register("'", "g:localleader_map")
nnoremap <silent> <localleader>     :WhichKey "'"<CR>
vnoremap <silent> <localleader>     :WhichKeyVisual "'"<CR>

let b:AutoPairs = {'(':')', '[':']', '{':'}', '"':'"'}

setl tw=80
