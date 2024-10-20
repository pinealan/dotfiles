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
Plug 'liuchengxu/vim-which-key'
Plug 'RRethy/vim-illuminate'
Plug 'luochen1990/rainbow'
Plug 'gyim/vim-boxdraw'
Plug 'kana/vim-textobj-user'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

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

Plug 'guns/vim-sexp', { 'for': [ 'clojure', 'scheme', 'lisp', 'timl' ] }
Plug '~/src/vim-iced', { 'for': 'clojure' }

Plug 'sheerun/vim-polyglot'

" Polyglot {{{2
let g:polyglot_disabled = ['clojure', 'markdown', 'python', 'solidity']

" Git Gutter {{{2
let g:gitgutter_map_keys = 0
let g:gitgutter_preview_win_floating = 1

" Schlepp {{{2
let g:Schlepp#allowSquishingLines = 0
let g:Schlepp#allowSquishingBlock = 0
let g:Schlepp#trimWS = 0

" rainbow {{{2
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
set termguicolors

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

" }}}

"===[ Mapping ]=== {{{

" Top level mapping {{{2

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

" Leader key mapping {{{2

nmap <leader>c      :Inspect<cr>
nmap <leader>ee     :edit %%

" buffers
nmap <leader>bd     :bd<cr>
nmap <leader>bn     :vnew<cr>

" fuzzy find (with telescope)
nmap <leader>ff     <cmd>Telescope find_files<cr>
nmap <leader>fe     <cmd>Telescope buffers<cr>
nmap <leader>fs     <cmd>Telescope live_grep<cr>

" git
nmap <leader>ga     :Gwrite<cr>
" Gwrite is effectively git add
nmap <leader>gb     :Git blame<cr>
nmap <leader>gc     :Git commit<cr>
nmap <leader>gd     :Git diff<cr>
nmap <leader>gg     :vert Git<cr>60<c-w>\|

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

" vim-which-key setup {{{2

let g:which_key_disable_default_offset = 1

let g:leader_map = {}

" defined by vimrc
let g:leader_map["'"] = "Split vertical"
let g:leader_map['"'] = "Split horizontal"
let g:leader_map['d'] = "Unload buffer"
let g:leader_map["h"] = "Toggle highlight search"
let g:leader_map['q'] = "Quit window"
let g:leader_map['<Tab>'] = "Goto alternate buffer"

" defined by nvim
let g:leader_map['c'] = "Show highlight group"
let g:leader_map["p"] = "Toggle paste mode"
let g:leader_map['r'] = "Replace word with register"
let g:leader_map['v'] = "Edit vimrc"

let g:leader_map['b'] = {
    \ 'name': '+buffer',
    \ 'd': 'Unload buffer',
    \ 'n': 'New empty buffer',
    \ }

let g:leader_map['f'] = {
    \ 'name': '+fuzzy find',
    \ 'e': 'Find buffer (telescope)',
    \ 'f': 'Find file (telescope)',
    \ 'r': 'Find string (telescope)',
    \ }

let g:leader_map['g'] = {
    \ 'name': '+git',
    \ 'a': 'Add',
    \ 'b': 'Blame',
    \ 'c': 'Commit',
    \ 'd': 'Diff',
    \ 'g': 'Status (vertical)',
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
