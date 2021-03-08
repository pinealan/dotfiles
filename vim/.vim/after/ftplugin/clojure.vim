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

" from vim-sexp
function! s:get_visual_marks()
    return [getpos("'<"), getpos("'>")]
endfunction

function! s:set_visual_marks(marks)
    call setpos("'<", a:marks[0])
    call setpos("'>", a:marks[1])
endfunction

" Return visually selected text without changing selection state and registers
function! GetSelectedCode() abort
    let reg_save = @@
    silent normal! y
    let result = @@
    let @@ = reg_save
    silent normal! gv
    return result
endfunction

function! SelectOuterUntilTop(top_code) abort
    let reg_save = @@
    try
        while (v:true)
            call sexp#select_current_list('v', 0, 1)
            let current_marks = s:get_visual_marks()

            call sexp#docount(2, 'sexp#select_current_list', 'v', 0, 1)
            let next_code = GetSelectedCode()

            if (next_code ==# a:top_code) | break | endif
        endwhile
        call s:set_visual_marks(current_marks)
        normal! gv
    finally
        let @@ = reg_save
    endtry
endfunction

function! SelectOuterTopList() abort
    let curpos = getpos('.')

    " First use vim-sexp optimized top form selector
    call sexp#select_current_top_list('v', 0)
    let top_code = GetSelectedCode()

    if (stridx(top_code, '(comment') == 0)
        " Select up one by one if the top list is a (comment ...) form
        execute "normal! \<Esc>"
        call setpos('.', curpos)
        call SelectOuterUntilTop(top_code)
    endif
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
    \ 'sexp_flow_to_prev_close':        '{',
    \ 'sexp_flow_to_next_open':         ')',
    \ 'sexp_flow_to_prev_open':         '(',
    \ 'sexp_flow_to_next_close':        '}',
    \ 'sexp_flow_to_prev_leaf_head':    'b',
    \ 'sexp_flow_to_next_leaf_head':    'w',
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
    \ 'sexp_insert_at_list_head':       '<localleader>h',
    \ 'sexp_insert_at_list_tail':       '<localleader>l',
    \ 'sexp_splice_list':               '<localleader>p',
    \ 'sexp_convolute':                 '<localleader>c',
    \ 'sexp_raise_list':                '<localleader>O',
    \ 'sexp_raise_element':             '<localleader>o',
    \ 'sexp_swap_list_backward':        '<F',
    \ 'sexp_swap_list_forward':         '>F',
    \ 'sexp_swap_element_backward':     '<E',
    \ 'sexp_swap_element_forward':      '>E',
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

""" Iced mappings {{{1

set keywordprg=:IcedDocumentPopupOpen

" Normal whitespace-based word navigation
" nnoremap <buffer>       W w
" xnoremap <buffer>       W w
" nnoremap <buffer>       B b
" xnoremap <buffer>       B b
" nnoremap <buffer>       E e
" xnoremap <buffer>       E e

nmap <localleader>'     :IcedConnect<cr>
nmap <localleader>rr    :IcedRequire<cr>
nmap <localleader>ee    m`<Plug>(iced_eval)<Plug>(sexp_inner_element)g``
nmap <localleader>ef    m`<Plug>(iced_eval)<Plug>(sexp_outer_list)g``
nmap <localleader>et    m`<Plug>(iced_eval):<c-u>call SelectOuterTopList()<cr>g``
nmap <localleader>epe   m`<Plug>(iced_eval_and_print)<Plug>(sexp_inner_element)g``
nmap <localleader>epf   m`<Plug>(iced_eval_and_print)<Plug>(sexp_outer_list)g``
nmap <localleader>ept   m`<Plug>(iced_eval_and_print):<c-u>call SelectOuterTopList()<cr>g``

xmap <localleader>ee    :IcedEvalVisual<cr>

nmap <localleader>hc    :IcedClojureDocsOpen<cr>
nmap <localleader>hs    :IcedSourcePopupShow<cr>

nmap <localleader>jl    :IcedJumpToLet<cr>

nmap <localleader>tt    :IcedTestUnderCursor<cr>
nmap <localLeader>tn    :IcedTestNs<cr>
nmap <localleader>tr    :IcedTestRedo<cr>
nmap <localLeader>tl    :IcedTestRerunLast<cr>

nmap <localleader>raa   :IcedAddArity<cr>
nmap <localLeader>ram   :IcedAddMissing<cr>
nmap <localLeader>ran   :IcedAddNs<cr>
nmap <localleader>rtf   :IcedThreadFirst<cr>
nmap <localleader>rtl   :IcedThreadLast<cr>
nmap <localleader>ref   :IcedExtractFunction<cr>
nmap <localleader>rml   :IcedMoveToLet<cr>

nmap <localleader>ss    :IcedStdoutBufferOpen<cr>
nmap <localleader>sl    :IcedStdoutBufferClear<cr>
nmap <localleader>sq    :IcedStdoutBufferClose<cr>

nmap <localleader>==    :IcedFormat<cr>
nmap <localleader>=G    :IcedFormatAll<cr>

nmap <localleader><Tab>     :edit <C-R>=AltSrcTestPath()<cr><cr>

""" WhichKey {{{1

let g:localleader_map = {}
let g:localleader_map['e'] = { 'name': '+iced-eval' }
let g:localleader_map['r'] = { 'name': '+iced-refactor' }
let g:localleader_map['s'] = { 'name': '+iced-stdout' }
let g:localleader_map['t'] = { 'name': '+iced-test' }
"let g:localleader_map['w'] = {
"    \ 'name': '+sexp-wrap-element',
"    \ 'w': '+sexp-wrap-element-insert',
"    \ }
"let g:localleader_map['W'] = {
"    \ 'name': '+sexp-wrap-list',
"    \ 'W': '+sexp-wrap-list-insert',
"    \ }

let g:localleader_map['c'] = 'sexp-convolute'
let g:localleader_map['p'] = 'sexp-splice'
let g:localleader_map['h'] = 'sexp-insert-at-head'
let g:localleader_map['l'] = 'sexp-insert-at-tail'
let g:localleader_map['o'] = 'sexp-raise-element'
let g:localleader_map['O'] = 'sexp-raise-list'
"let g:localleader_map['='] = 'iced-format'
let g:localleader_map['<Tab>'] = "edit-test-file"

call which_key#register("'", "g:localleader_map")
nnoremap <silent> <localleader>     :WhichKey "'"<CR>
vnoremap <silent> <localleader>     :WhichKeyVisual "'"<CR>

let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"', '`':'`'}
