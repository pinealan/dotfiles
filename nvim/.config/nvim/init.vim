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

Plug 'liuchengxu/vim-which-key'
Plug 'RRethy/vim-illuminate'
Plug 'kana/vim-textobj-user'

" Git Gutter {{{2
let g:gitgutter_map_keys = 0
let g:gitgutter_preview_win_floating = 1
" }}}
" Schlepp {{{2
let g:Schlepp#allowSquishingLines = 0
let g:Schlepp#allowSquishingBlock = 0
let g:Schlepp#trimWS = 0
" }}}

" Neovim only
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'norcalli/nvim-colorizer.lua'
Plug 'neovim/nvim-lspconfig'
Plug 'm4xshen/autoclose.nvim'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'hiphish/rainbow-delimiters.nvim'
Plug 'windwp/nvim-ts-autotag'

" Autocompletion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" Languages
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'jeetsukumaran/vim-pythonsense'

Plug 'guns/vim-sexp'
Plug '~/src/vim-iced', { 'for': 'clojure' }

Plug 'sheerun/vim-polyglot'

" Polyglot {{{2
let g:polyglot_disabled = ['clojure', 'markdown', 'python', 'solidity']
let g:rustfmt_autosave = 1
" }}}

call plug#end()

" }}}

source ~/.vim/vimrc
set termguicolors
set completeopt=menu,menuone,noinsert,noselect

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

" Debug {{{2
function! InspectRTP()
    for s in split(&rtp, ',')
        echo s
    endfor
endfunction

" }}}

" }}}

"===[ Commands ]=== {{{
"
command! DarkMode
    \ set background=dark |
    \ colorscheme my-onedark

command! LightMode
    \ set background=light |
    \ colorscheme my-onelight

" }}}

"===[ Mapping ]=== {{{

" Top level mapping {{{2

cnoremap %% <C-R>=substitute(expand('%:h').'/', '^\./', '', '')<cr>

" Swap undo
noremap    U   <C-r>
noremap <C-r>     U

" Keep commands from moving the cursor around
nnoremap <silent> *    <cmd>keepjumps normal! mz*`z<cr><cmd>SearchIndex<cr>
nnoremap <silent> #    <cmd>keepjumps normal! mz#`z<cr><cmd>SearchIndex<cr>
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

map <C-q>           <cmd>cclose<cr>
map <C-S-q>         <cmd>copen<cr>
map <C-s>           <cmd>update<cr>
map <C-r>           <cmd>edit<cr>

nmap <silent> -     <cmd>call Underline('-')<cr>
nmap <silent> =     <cmd>call Underline('=')<cr>

noremap <silent> <M-d>   5<C-e>
noremap <silent> <M-e>   5<C-y>

vmap <up>       <Plug>SchleppUp
vmap <down>     <Plug>SchleppDown
vmap <left>     <Plug>SchleppLeft
vmap <right>    <Plug>SchleppRight

nmap gs         <Plug>(GitGutterStageHunk)
nmap gu         <Plug>(GitGutterUndoHunk)
nmap g[         <Plug>(GitGutterPrevHunk)
nmap g]         <Plug>(GitGutterNextHunk)
nmap gp         <Plug>(GitGutterPreviewHunk)

" Leader key mapping {{{2

nmap <leader>c      <cmd>Inspect<cr>
nmap <leader>e      :edit %%

" buffers
nmap <leader>bd     <cmd>bd<cr>
nmap <leader>bn     <cmd>vnew<cr>

" fuzzy find (with telescope)
nmap <leader>fp     <cmd>lua require('pinealan').project_files()<cr>
nmap <leader>ff     <cmd>Telescope find_files<cr>
nmap <leader>fe     <cmd>Telescope buffers<cr>
nmap <leader>fs     <cmd>Telescope live_grep<cr>

" git
nmap <leader>ga     :Gwrite<cr>
" Gwrite is effectively git add
nmap <leader>gb     <cmd>Git blame<cr>
nmap <leader>gc     <cmd>Git commit<cr>
nmap <leader>gd     <cmd>Git diff<cr>
nmap <leader>gg     <cmd>vert Git<cr>60<c-w>\|

" toggles
nmap <silent> <leader>td    <cmd>lua vim.diagnostic.enable(not vim.diagnostic.is_enabled({ bufnr = 0 }), { bufnr = 0 })<cr>
nmap <silent> <leader>tg    <cmd>GitGutterToggle<cr>
nmap <silent> <leader>tj    <cmd>call ToggleFastEsc()<cr>
nmap <silent> <leader>tp    <cmd>setlocal paste!<cr>
nmap <silent> <leader>tr    <cmd>call rainbow_delimiters#toggle(0)<cr>
nmap <silent> <leader>ts    <cmd>setlocal spell!<cr>
nmap <silent> <leader>tw    <cmd>setlocal wrap!<cr>

" editing
nmap <leader>r      "_dwP
nmap <leader>xt     <cmd>Tabularize /
nmap <leader>xx     <cmd>s/ \+/\r/g<cr>

" windows
nmap <leader>w=     <C-w>=
nmap <leader>wo     <cmd>tab sp<cr>
nmap <leader>wt     <C-w>T
nmap <leader>ww     <cmd>w<cr>

nmap <leader>xr     <cmd>so $MYVIMRC<cr>
nmap <leader>xv     <cmd>edit $MYVIMRC<cr>

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
let g:leader_map['e'] = "Edit file in current directory"

let g:leader_map['l'] = "LSP: Open diagnostics in floating window"
let g:leader_map['H'] = 'LSP: Signature Help'
let g:leader_map['R'] = 'LSP: Rename symbol '
let g:leader_map['['] = "LSP: Goto prev diagnostic"
let g:leader_map[']'] = "LSP: Goto next diagnostic"
let g:leader_map['ca'] = "LSP: code action"

let g:leader_map['b'] = {
    \ 'name': '+buffer',
    \ 'd': 'Unload buffer',
    \ 'n': 'New empty buffer',
    \ }

let g:leader_map['f'] = {
    \ 'name': '+fuzzy-find',
    \ 'e': 'Find buffer (telescope)',
    \ 'f': 'Find file (telescope)',
    \ 'p': 'Find project file (telescope)',
    \ 's': 'Find string (telescope)',
    \ }

let g:leader_map['g'] = {
    \ 'name': '+git',
    \ 'a': 'Git Add',
    \ 'b': 'Git Blame',
    \ 'c': 'Git Commit',
    \ 'd': 'Git Diff',
    \ 'g': 'Git Status (vertical)',
    \ }

let g:leader_map['s'] = {
    \ 'name': '+set',
    \ 'r': 'Illuminate with regex',
    \ 'l': 'Illuminate with lsp',
    \ }

let g:leader_map['t'] = {
    \ 'name': '+toggle',
    \ 'd': 'Toggle LSP Diagnostics',
    \ 'g': 'Toggle Git gutter',
    \ 'j': 'Toggle Fast escape (jj)',
    \ 'p': 'Toggle Paste mode',
    \ 'r': 'Toggle Rainbow parens',
    \ 's': 'Toggle Spell check',
    \ 'w': 'Toggle Soft wrap',
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
    \ 'r': 'Reload vimrc',
    \ 'v': 'Edit vimrc',
    \ 't': 'Tabularize',
    \ 'x': 'Split line by spaces',
    \ }

call which_key#register(' ', "g:leader_map")
nnoremap <silent> <leader>  <cmd>WhichKey '<space>'<cr>
vnoremap <silent> <leader>  <cmd>WhichKeyVisual '<space>'<cr>

" }}}

" }}}

"===[ Autocommands setup ]=== {{{
"
augroup usr
    autocmd!
    autocmd BufEnter    * silent call EnableFastEsc()
    autocmd BufNewfile  *.php silent r ~/.vim/template/template.php | normal kdd
    autocmd BufRead     *.vim silent set foldmethod=marker
    autocmd BufWrite    * call TryTrimSpace()
    "autocmd VimEnter    *.c,*.cpp,*.py vsp

    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g'\"" |
        \ endif


    autocmd BufNewFile,BufRead  *.sol setf solidity
    autocmd BufWritePost        *.sync.py !jupytext -s %

    autocmd BufEnter    iced_stdout lua vim.diagnostic.enable(false, { bufnr = 0 })

augroup END

" }}}
