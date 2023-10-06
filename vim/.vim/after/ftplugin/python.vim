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

" Taken from https://github.com/GCBallesteros/vim-textobj-hydrogen

function! s:move_p()
  let next_line = search("^# %%", "bnW")

  " Just in case the notebook has no starting cell.
  if next_line == 0
    let next_line = 2
  endif

  let curr_pos = getpos('.')
  let pos = [curr_pos[0], next_line, 1, curr_pos[3]]

  return ['V', pos, 0]
endfunction

function! s:move_n()
  let next_line = search("^# %%", "nW")

  if next_line == 0 " We are the last cell
    let next_line = line('$')
  else
    let next_line = next_line - 1
  endif

  let curr_pos = getpos('.')
  let next_pos = [curr_pos[0], next_line + 1, 0, curr_pos[3]]

  return ['V', next_pos, 0]
endfunction

function! s:select_a()
  let start_line = search("^# %%", "cbnW")
  let end_line = search("^# %%", "nW")

  " Just in case the notebook is malformed and doesnt
  " have a cell marker at the start.
  if start_line == 0
    let start_line = 1
  endif

  if end_line == 0 " We are the last cell
    let end_line = line('$')
  else
    let end_line = end_line - 1
  endif

  let curr_pos = getpos('.')
  let start_pos = [curr_pos[0], start_line , 1, curr_pos[3]]
  let end_pos = [curr_pos[0], end_line, 0, curr_pos[3]]

  return ['V', start_pos, end_pos]
endfunction

function! s:select_i()
  let start_line = search("^# %%", "cbnW")
  let end_line = search("^# %%", "nW")

  " Just in case the notebook is malformed and doesnt
  " have a cell marker at the start.
  if start_line == 0
    let start_line = 1
  endif

  if end_line == 0 " We are the last cell
    let end_line = line('$')
  else
    let end_line = end_line - 1
  endif

  let curr_pos = getpos('.')
  let start_pos = [curr_pos[0], start_line + 1 , 1, curr_pos[3]]
  let end_pos = [curr_pos[0], end_line, 0, curr_pos[3]]

  return ['V', start_pos, end_pos]
endfunction

hi link @attribute          Special
hi link @constructor        Normal
hi link @field              Normal
hi link @variable           Normal
hi link @variable.builtin   Special

call textobj#user#plugin('pypercent', {
\      '-': {
\        '*sfile*': expand('<sfile>:p'),
\        'select-a': 'ae',  '*select-a-function*': 's:select_a',
\        'select-i': 'ie',  '*select-i-function*': 's:select_i',
\        'move-n': ']e',    '*move-n-function*': 's:move_n',
\        'move-p': '[e',    '*move-p-function*': 's:move_p'
\      }
\    })

nmap <localleader>gk        :vimgrep /^ *class/g @%
nmap <localleader><Tab>     :edit <C-R>=AltSrcTestPath()<cr><cr>

" Mappings for working with percent scripts (jupyter notebook as text)
nmap <localleader>j  ]e
nmap <localleader>k  [e

nmap <localleader>a  [ek<cr>i# %%<esc><cr><cr>k
nmap <localleader>b  ]ek<cr>i# %%<esc><cr><cr>k
nmap <localleader>d  dae

""" WhichKey {{{1

let g:localleader_map = {}

let g:localleader_map['a'] = 'Create cell above'
let g:localleader_map['b'] = 'Create cell below'
let g:localleader_map['d'] = 'Delete cell'
let g:localleader_map['j'] = 'Move to next cell'
let g:localleader_map['k'] = 'Move to previous cell'

call which_key#register("'", "g:localleader_map")
nnoremap <silent> <localleader>     :WhichKey "'"<CR>
vnoremap <silent> <localleader>     :WhichKeyVisual "'"<CR>

augroup usr
    autocmd BufWritePost    *.sync.py !jupytext -s %
augroup END
