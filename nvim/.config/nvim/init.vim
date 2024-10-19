set runtimepath^=~/.vim runtimepath+=~/.vim/after

"===[ Plugin ]=== {{{
"
filetype off
set nocompatible

call plug#begin()

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'google/vim-searchindex'
Plug 'godlygeek/tabular'
Plug 'zirrostig/vim-schlepp'

Plug 'jiangmiao/auto-pairs'
Plug '/nix/store/3zc8kjdicrkwlby25dajz3d6bjrdwq08-fzf-0.55.0/share/vim-plugins/fzf'
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vim-which-key'
Plug 'RRethy/vim-illuminate'
Plug 'luochen1990/rainbow'
Plug 'gyim/vim-boxdraw'
Plug 'kana/vim-textobj-user'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'nvim-treesitter/nvim-treesitter'

" Languages
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'jeetsukumaran/vim-pythonsense'

Plug 'guns/vim-sexp', { 'for': ['clojure', 'scheme', 'lisp', 'timl'] }
Plug '~/src/vim-iced', { 'for': 'clojure' }

Plug 'sheerun/vim-polyglot'

" Polyglot {{{

let g:polyglot_disabled = ['clojure', 'markdown', 'python', 'solidity']

" }}}
" Git Gutter {{{

let g:gitgutter_map_keys = 0
let g:gitgutter_preview_win_floating = 1

" }}}
" Schlepp {{{

let g:Schlepp#allowSquishingLines = 0
let g:Schlepp#allowSquishingBlock = 0
let g:Schlepp#trimWS = 0

" }}}
" FZF {{{

let g:fzf_command_prefix = "Fzf"
let g:fzf_layout = {'window': { 'width': 0.8, 'height': 0.6 }}

" }}}
" rainbow {{{

let g:rainbow_active = 1
let g:rainbow_conf = {
    \ 'guifgs': [
    \   '#828282',
    \   'royalblue3',
    \   'darkorange4',
    \   'seagreen4',
    \   'firebrick',
    \   'darkorchid3'
    \   ],
    \ }

" }}}

call plug#end()

" }}}

source ~/.vim/vimrc

"===[ Functions ]=== {{{

function! EnableFastEsc()
    let b:fastesc=1
    inoremap <buffer> jj <esc>
    echom "Enabled insert mdoe fast <esc>"
endfunction

function! DisableFastEsc()
    unlet b:fastesc
    iunmap <buffer> jj
    echom "Disabled insert mdoe fast <esc>"
endfunction

function! ToggleFastEsc()
    if get(b:, 'fastesc', 0)
        call DisableFastEsc()
    else
        call EnableFastEsc()
    endif
endfunction

function! Underline(symbol)
    let line = getline('.')
    let llen = strlen(line)
    let str = ''
    if llen > 0
        let widx = match(line, '\S')
        for ii in range(widx)
            let str = str . " "
        endfor
        for ii in range(llen - widx)
            let str = str . a:symbol
        endfor
        call setreg("y", str)
        exec "normal! o\<esc>\"yp"
    endif
endfunction

function! TrimSpace()
    %s/\s\+$//e
endfunction

function! TryTrimSpace()
    if &ft =~ 'markdown'
        return
    else
        call TrimSpace()
    endif
endfunction

function! RipgrepFzf(query, fullscreen)
  let command_fmt = join([
    \ 'rg',
    \ '--column',
    \ '--line-number',
    \ '--no-heading',
    \ '--color=always',
    \ '--smart-case',
    \ '-- %s || true'
    \ ], ' ')
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {
    \ 'options': [
    \   '--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command
    \ ]}
  call fzf#vim#grep(
    \ initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

" }}}

"===[ Commands ]=== {{{
"
command! MyStatusLineShort
    \ set statusline=%!MyStatusLine('t') |
    \ echohl Debug |
    \ echo "Relative path (statusline)"
command! MyStatusLineLong
    \ set statusline=%!MyStatusLine('f') |
    \ echohl Debug |
    \ echo "Full path (statusline)"

command! Files
    \ call fzf#run(fzf#wrap('files-all', {'source': 'fd . -H -L -E .git -t f'}))
command! FilesAll
    \ call fzf#run(fzf#wrap('files-all', {'source': 'fd . -H -I -L -t f -t l'}))
command! -nargs=* -bang RG
    \ call RipgrepFzf(<q-args>, <bang>0)

" }}}

"===[ Mapping ]=== {{{
"
cnoremap %% <C-R>=substitute(expand('%:h').'/', '^\./', '', '')<cr>

" Swap undo
noremap    U   <C-r>
noremap <C-r>     U

" Keep commands from moving the cursor around
nnoremap <silent> n    nzzzv<cmd>SearchIndex<cr>
nnoremap <silent> N    Nzzzv<cmd>SearchIndex<cr>
nnoremap <silent> J    mzJ`z

" Easier newline
nnoremap <cr>  o<esc>
nnoremap Y     y$

" Windows navigation
map <silent> <M-h>   <C-w>h
map <silent> <M-j>   <C-w>j
map <silent> <M-k>   <C-w>k
map <silent> <M-l>   <C-w>l

" Buffer/Tab/Quickfix navigation
map <C-q>      :q<cr>
map <C-s>      :update<cr>
map <C-r>      :edit<cr>

map <C-h>      :tabprev<cr>
map <C-l>      :tabnext<cr>

nmap <silent> -     :call Underline('-')<cr>
nmap <silent> =     :call Underline('=')<cr>

noremap <silent> <M-d>   <C-e>
noremap <silent> <M-e>   <C-y>

vmap <up>      <Plug>SchleppUp
vmap <down>    <Plug>SchleppDown
vmap <left>    <Plug>SchleppLeft
vmap <right>   <Plug>SchleppRight

nmap gs     <Plug>(GitGutterStageHunk)
nmap gu     <Plug>(GitGutterUndoHunk)
nmap g[     <Plug>(GitGutterPrevHunk)
nmap g]     <Plug>(GitGutterNextHunk)
nmap gp     <Plug>(GitGutterPreviewHunk)

" Mnemonic leader mapping to commands {{{

nmap <leader>:      :Commands<cr>
nmap <leader>c      :Inspect<cr>

" buffers
nmap <leader>bb     :FzfBuffers<cr>
nmap <leader>bd     :bd<cr>
nmap <leader>bn     :vnew<cr>

" use e as alias of buffEr mnemonics
nmap <leader>e      :FzfBuffers<cr>

" files
nmap <leader>fa     :FilesAll<cr>
nmap <leader>fe     :edit %%
nmap <leader>ff     :Files<cr>
nmap <leader>fh     :edit ~/
nmap <leader>fr     :FzfHistory<cr>
nmap <leader>fz     :call fzf#run(fzf#wrap('fzf-custom', {'source': ''}))

" git
nmap <leader>gc     :Git commit<cr>
nmap <leader>ga     :Gwrite<cr>
nmap <leader>gb     :Git blame<cr>
nmap <leader>gc     :FzfCommits<cr>
nmap <leader>gd     :Git diff<cr>
nmap <leader>gf     :FzfGFiles<cr>
nmap <leader>gg     :vert Git<cr>60<c-w>\|
nmap <leader>gl     :Glog<cr>
nmap <leader>gs     :Git<cr>
nmap <leader>gv     :Gvdiffsplit<cr>

" search
nmap <leader>s/     :FzfHistory/<cr>
nmap <leader>s:     :FzfHistory:<cr>
nmap <leader>sB     :FzfLines<cr>
nmap <leader>sb     :FzfBLines<cr>
nmap <leader>sc     :FzfCommands<cr>
nmap <leader>ss     :RG<cr>

" toggles
nmap <silent> <leader>t1    :MyStatusLineLong<cr>
nmap <silent> <leader>t2    :MyStatusLineShort<cr>
nmap <silent> <leader>tg    :GitGutterToggle<cr>
nmap <silent> <leader>tj    :call ToggleFastEsc()<cr>
nmap <silent> <leader>tp    :setlocal paste!<cr>
nmap <silent> <leader>tr    :RainbowToggle<cr>
nmap <silent> <leader>ts    :setlocal spell!<cr>
nmap <silent> <leader>tw    :setlocal wrap!<cr>

" vim
nmap <leader>r      "_dwP
nmap <leader>v      :e ~/.vim/vimrc<cr>

" windows
nmap <leader>w=     <C-w>=
nmap <leader>wo     :tab sp<cr>
nmap <leader>wt     <C-w>T
nmap <leader>ww     :w<cr>

nmap <leader>xt     :Tabularize /
nmap <leader>xr     :s/ \+/\r/g<cr>

" }}}
" vim-which-key setup {{{

let g:which_key_disable_default_offset = 1

let g:leader_map = {}

"let g:leader_map[" "] = "Toggle highlight search (dup h)"
let g:leader_map["'"] = "Split vertical"
let g:leader_map['"'] = "Split horizontal"
let g:leader_map[':'] = "Search commands"

let g:leader_map['c'] = "Show highlight group"
let g:leader_map['e'] = "Search buffer by name"
let g:leader_map['d'] = "Unload buffer"
let g:leader_map["h"] = "Toggle highlight search"
let g:leader_map["p"] = "Toggle paste mode"
let g:leader_map['q'] = "Quit window"
let g:leader_map['r'] = "Replace word with register"
let g:leader_map['v'] = "Edit vimrc"

let g:leader_map['<Tab>'] = "Goto alternate buffer"

let g:leader_map['b'] = {
    \ 'name': '+buffer',
    \ 'b': 'Find buffer',
    \ 'd': 'Unload buffer',
    \ 'n': 'New empty buffer',
    \ }

let g:leader_map['f'] = {
    \ 'name': '+file',
    \ 'a': 'Find all files including vcs-ignored',
    \ 'e': 'Edit adjacent file',
    \ 'f': 'Find file',
    \ 'h': 'Edit file from home directory',
    \ 'r': 'Recent files',
    \ 'z': 'FZF function call template',
    \ }

let g:leader_map['g'] = {
    \ 'name': '+git',
    \ 'a': 'Add',
    \ 'b': 'Blame',
    \ 'c': 'Search commits',
    \ 'd': 'Diff',
    \ 'g': 'Status (vertical)',
    \ 'l': 'File history',
    \ 's': 'Status',
    \ 'v': 'Diff (vertical)',
    \ 'C': 'Commit',
    \ }

let g:leader_map["s"] = {
    \ 'name': '+search',
    \ '/': 'Recent searchs',
    \ ':': 'Recent commands',
    \ 'B': 'Search in buffer',
    \ 'b': 'Search in all buffers',
    \ 'c': 'Search vim commands',
    \ 's': 'Search text recursively',
    \ }

let g:leader_map['t'] = {
    \ 'name': '+toggle',
    \ 'g': 'Git gutter',
    \ 'h': 'Highlight search',
    \ 'j': 'Fast escape (jj)',
    \ 'p': 'Paste mode',
    \ 'r': 'Rainbow parens',
    \ 's': 'Spell check',
    \ 'w': 'Soft wrap',
    \ }

let g:leader_map['w'] = {
    \ 'name': '+window',
    \ '=': 'Balance windows',
    \ 'o': 'Open in new tabpage',
    \ 't': 'Move to new tabpage',
    \ 'w': 'Jump to last window',
    \ }

let g:leader_map['x'] = {
    \ 'name': '+execute',
    \ 'r': 'Split line by spaces',
    \ 't': 'Tabularize',
    \ }

call which_key#register(' ', "g:leader_map")
nnoremap <silent> <leader>          :WhichKey '<space>'<cr>
vnoremap <silent> <leader>          :WhichKeyVisual '<space>'<cr>

" }}}

" }}}

"===[ Autocommands setup ]=== {{{
"
augroup usr
    autocmd!
    autocmd BufEnter    * silent call EnableFastEsc()
    autocmd BufNewfile  *.php silent r ~/.vim/template/template.php | normal kdd
    autocmd BufRead     *.vim silent set foldmethod=marker
    autocmd BufRead     *.html silent RainbowToggle
    autocmd BufWrite    * call TryTrimSpace()
    "autocmd VimEnter    *.c,*.cpp,*.py vsp

    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g'\"" |
        \ endif


    autocmd BufNewFile,BufRead  *.sol setf solidity
    autocmd BufWritePost        *.sync.py !jupytext -s %

augroup END

" }}}

set termguicolors
lua require('pinealan')
