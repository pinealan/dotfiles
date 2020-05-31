" doing my own mappings because the defaults uses <Leader> or <M-*>
"
let g:sexp_enable_insert_mode_mappings = 0
let g:sexp_mappings = {
    \ 'sexp_outer_list':                'af',
    \ 'sexp_inner_list':                'if',
    \ 'sexp_outer_top_list':            'aF',
    \ 'sexp_inner_top_list':            'iF',
    \ 'sexp_outer_string':              'as',
    \ 'sexp_inner_string':              'is',
    \ 'sexp_outer_element':             'ae',
    \ 'sexp_inner_element':             'ie',
    \ 'sexp_move_to_prev_bracket':      '[f',
    \ 'sexp_move_to_next_bracket':      ']f',
    \ 'sexp_move_to_prev_element_head': 'B',
    \ 'sexp_move_to_next_element_head': 'W',
    \ 'sexp_move_to_prev_element_tail': 'gE',
    \ 'sexp_move_to_next_element_tail': 'E',
    \ 'sexp_flow_to_prev_close':        '{',
    \ 'sexp_flow_to_next_open':         ')',
    \ 'sexp_flow_to_prev_open':         '(',
    \ 'sexp_flow_to_next_close':        '}',
    \ 'sexp_flow_to_prev_leaf_head':    'b',
    \ 'sexp_flow_to_next_leaf_head':    'w',
    \ 'sexp_flow_to_prev_leaf_tail':    'ge',
    \ 'sexp_flow_to_next_leaf_tail':    'e',
    \ 'sexp_move_to_prev_top_element':  '[[',
    \ 'sexp_move_to_next_top_element':  ']]',
    \ 'sexp_select_prev_element':       '[e',
    \ 'sexp_select_next_element':       ']e',
    \ 'sexp_indent':                    '==',
    \ 'sexp_indent_top':                '=-',
    \ 'sexp_round_head_wrap_list':      '<localleader>I',
    \ 'sexp_round_tail_wrap_list':      '<localleader>A',
    \ 'sexp_square_head_wrap_list':     '<localleader>[',
    \ 'sexp_square_tail_wrap_list':     '<localleader>]',
    \ 'sexp_curly_head_wrap_list':      '<localleader>{',
    \ 'sexp_curly_tail_wrap_list':      '<localleader>}',
    \ 'sexp_round_head_wrap_element':   '<localleader>i',
    \ 'sexp_round_tail_wrap_element':   '<localleader>a',
    \ 'sexp_square_head_wrap_element':  '<localleader>e[',
    \ 'sexp_square_tail_wrap_element':  '<localleader>e]',
    \ 'sexp_curly_head_wrap_element':   '<localleader>e{',
    \ 'sexp_curly_tail_wrap_element':   '<localleader>e}',
    \ 'sexp_insert_at_list_head':       '<localleader>h',
    \ 'sexp_insert_at_list_tail':       '<localleader>l',
    \ 'sexp_splice_list':               '<localleader>s',
    \ 'sexp_convolute':                 '<localleader>?',
    \ 'sexp_raise_list':                '<localleader>O',
    \ 'sexp_raise_element':             '<localleader>o',
    \ 'sexp_swap_list_backward':        '<F',
    \ 'sexp_swap_list_forward':         '>F',
    \ 'sexp_swap_element_backward':     '<E',
    \ 'sexp_swap_element_forward':      '>E',
    \ 'sexp_emit_head_element':         '>(',
    \ 'sexp_emit_tail_element':         '<)',
    \ 'sexp_capture_prev_element':      '<(',
    \ 'sexp_capture_next_element':      '>)',
    \ }

nmap <localleader>'    :IcedConnect<cr>
nmap <localleader>rr   :IcedRequire<cr>
nmap <localleader>ee   <Plug>(iced_eval)<Plug>(sexp_inner_element)
nmap <localleader>ef   <Plug>(iced_eval)<Plug>(sexp_outer_list)
nmap <localleader>eF   <Plug>(iced_eval_outer_top_list)
nmap <localleader>epe  <Plug>(iced_eval_and_print)<Plug>(sexp_inner_element)
nmap <localleader>epf  <Plug>(iced_eval_and_print)<Plug>(sexp_outer_list)
nmap <localleader>epF  <Plug>(iced_eval_and_print)<Plug>(sexp_outer_top_list)

nmap K                 :IcedDocumentPopupOpen<cr>
nmap <localleader>hc   :IcedClojureDocsOpen<cr>
nmap <localleader>hs   :IcedSourcePopupShow<cr>

nmap <localleader>jl   :IcedJumpToLet<cr>

nmap <localleader>tt   :IcedTestUnderCursor<cr>
nmap <localLeader>tn   :IcedTestNs<cr>
nmap <localleader>tr   :IcedTestRedo<cr>
nmap <localLeader>tl   :IcedTestRerunLast<cr>

nmap <localleader>raa  :IcedAddArity<cr>
nmap <localLeader>ram  :IcedAddMissing<cr>
nmap <localLeader>ran  :IcedAddNs<cr>
nmap <localleader>rtf  :IcedThreadFirst<cr>
nmap <localleader>rtl  :IcedThreadLast<cr>
nmap <localleader>ref  :IcedExtractFunction<cr>
nmap <localleader>rml  :IcedMoveToLet<cr>

nmap <localleader>ss   :IcedStdoutBufferOpen<cr>
nmap <localleader>sl   :IcedStdoutBufferClear<cr>
nmap <localleader>sq   :IcedStdoutBufferClose<cr>

nmap <localleader>==   :IcedFormat<cr>
nmap <localleader>=G   :IcedFormatAll<cr>

nmap <localleader><Tab>     :edit <C-R>=AltSrcTestPath()<cr><cr>

let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"', '`':'`'}

function! AltSrcTestPath()
    let path = expand('%:r')
    if path =~# '^src'
        return substitute( path.'_test.clj','^src','test','' )
    elseif path =~# '^test'
        return substitute( substitute(path,'_test','',''),'^test','src','' ).'.clj'
    else
        echom 'File path does not start with "src" or "test"'
        return expand('%')
endfunction
