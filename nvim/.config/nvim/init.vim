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
Plug 'romainl/vim-qf'

Plug 'RRethy/vim-illuminate'
Plug 'kana/vim-textobj-user'

" Git Gutter {{{2
let g:gitgutter_map_keys = 0
let g:gitgutter_preview_win_floating = 1
" Turn off signs column by default
let g:gitgutter_signs = 0
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
Plug 'chentoast/marks.nvim'
Plug 'folke/which-key.nvim'

Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-neo-tree/neo-tree.nvim'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'hiphish/rainbow-delimiters.nvim'
Plug 'windwp/nvim-ts-autotag'

" Autocompletion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-buffer'
"Plug 'hrsh7th/cmp-path'
Plug 'https://codeberg.org/FelipeLema/cmp-async-path.git'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" Languages
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'mfussenegger/nvim-jdtls'

Plug 'guns/vim-sexp'
Plug '~/src/vim-iced', { 'for': 'clojure' }
Plug '~/lab/callisto'

Plug 'sheerun/vim-polyglot'

" Polyglot {{{2
let g:polyglot_disabled = ['clojure', 'markdown', 'python', 'solidity']
let g:rustfmt_autosave = 1
" }}}

call plug#end()

" }}}

"===[ Load and override vimrc ]=== {{{

source ~/.vim/vimrc
set termguicolors
set completeopt=menu,menuone,noinsert,noselect

set laststatus=2
set numberwidth=2
set signcolumn=auto:2
set updatetime=100

" Extend statusline function
function! GitStatus()
    let [a, m, r] = GitGutterGetHunkSummary()
    return printf('(+%d ~%d -%d)', a, m, r)
endfunction

" Override statusline function defined in vimrc
function! MyStatusLine()
    " [Flags] <File name> (git stats)
    " ~gap~
    " [File type] Row,Column | Percent down file
    return join([
        \' %q%w%r%m%{HasPaste()}',
        \'%{MyBufName()} %{FugitiveStatusline()}',
        \'%=',
        \'%y %l,%-2c |%3p%% '
        \], '')
endfunction

" }}}

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

" Motions {{{3

" Swap undo
noremap    U   <C-r>
noremap <C-r>     U

" Keep commands from moving the cursor around
nnoremap <silent> *    <cmd>keepjumps normal! mz*`z<cr><cmd>SearchIndex<cr>
nnoremap <silent> #    <cmd>keepjumps normal! mz#`z<cr><cmd>SearchIndex<cr>
nnoremap <silent> n    nzzzv<cmd>SearchIndex<cr>
nnoremap <silent> N    Nzzzv<cmd>SearchIndex<cr>
nnoremap <silent> J    mzJ`z

" Override default where these motions add to jumplist
nnoremap <silent> L    <cmd>keepjumps normal! L<cr>
nnoremap <silent> M    <cmd>keepjumps normal! M<cr>
nnoremap <silent> H    <cmd>keepjumps normal! H<cr>

" Easier newline
nnoremap <cr>  o<esc>
nnoremap Y     y$

" Windows navigation
nmap <silent> <M-h>   <C-w>h
nmap <silent> <M-j>   <C-w>j
nmap <silent> <M-k>   <C-w>k
nmap <silent> <M-l>   <C-w>l

"nmap <silent> -     <cmd>call Underline('-')<cr>
"nmap <silent> =     <cmd>call Underline('=')<cr>

" Scroll
noremap <silent> <M-d>   5<C-e>
noremap <silent> <M-e>   5<C-y>

nnoremap <silent> , '

" }}}

" Editing {{{3

" Emacs-style motion shortcuts for insert mode
inoremap <M-f>  <esc>gEWWi
inoremap <M-b>  <esc>gEBi
inoremap <C-a>  <esc>0i
inoremap <C-e>  <esc>$a

" Surround
imap <M-'>      <esc>ysiw'
imap <M-">      <esc>ysiw"
imap <M-(>      <esc>ysiw)
imap <M-[>      <esc>ysiw]
imap <M-{>      <esc>ysiw}

nmap <M-'>      ysiw'
nmap <M-">      ysiw"
nmap <M-(>      ysiw)
nmap <M-{>      ysiw}

nmap <M-r>      :s/
nmap <M-R>      :%s/
xmap <M-r>      :s/

" Comments (new in neovim)
nmap <M-/>      gcc
vmap <M-/>      gc
imap <M-/>      <esc>gcc`^a

vmap <up>       <Plug>SchleppUp
vmap <down>     <Plug>SchleppDown
vmap <left>     <Plug>SchleppLeft
vmap <right>    <Plug>SchleppRight
" }}}

" Cmdline {{{3
cnoremap %%     <C-R>=substitute(expand('%:h'), '^\(\w\)', './\1', '').'/'<cr>
cnoremap @@     \(.*\)
cnoremap <M-f>  <S-Right>
cnoremap <M-b>  <S-Left>
cnoremap <C-a>  <C-b>
" }}}

" Buffer/File management {{{3
map <C-s>           <cmd>update<cr>
map <C-r>           <cmd>edit<cr>
" To complement the builtin <C-w>n which maps to :new
map <C-w>N          <cmd>vnew<cr>
" }}}

" Quickfix {{{3
map <C-S-q>         <cmd>cclose<cr>
map <C-q>           <cmd>copen<cr>
map <C-q>
" Override keymaps from `vim-qf` plugin
map <M-n>       <Plug>(qf_loc_next)
map <M-p>       <Plug>(qf_loc_previous)
map <C-n>       <Plug>(qf_qf_next)
map <C-p>       <Plug>(qf_qf_previous)
" }}}

" GitGutter {{{3
nmap gs         <Plug>(GitGutterStageHunk)
nmap gu         <Plug>(GitGutterUndoHunk)
nmap g[         <Plug>(GitGutterPrevHunk)
nmap g]         <Plug>(GitGutterNextHunk)
nmap gp         <Plug>(GitGutterPreviewHunk)

omap ih         <Plug>(GitGutterTextObjectInnerPending)
omap ah         <Plug>(GitGutterTextObjectOuterPending)
xmap ih         <Plug>(GitGutterTextObjectInnerVisual)
xmap ah         <Plug>(GitGutterTextObjectOuterVisual)
" }}}

" }}}

" Leader key mapping {{{2

nmap <leader>c      <cmd>Inspect<cr>
nmap <leader>e      :edit %%<C-space>

" buffers
nmap <leader>bc     <cmd>%bd \| e#<cr>
nmap <leader>bd     <cmd>bd<cr>
nmap <leader>bn     <cmd>vnew<cr>

" git {{{3
" Gwrite is effectively git add
nmap <leader>ga     <cmd>Gwrite<cr>
nmap <leader>gb     <cmd>Git blame<cr>
nmap <leader>gc     <cmd>Git commit<cr>
nmap <leader>gd     <cmd>Git diff<cr>
nmap <leader>gg     <cmd>Git<cr>
" }}}

" toggles {{{3
nmap <silent> <leader>tc    <cmd>TSContextToggle<cr>
nmap <silent> <leader>td    <cmd>lua vim.diagnostic.enable(not vim.diagnostic.is_enabled({ bufnr = 0 }), { bufnr = 0 })<cr>
nmap <silent> <leader>tg    <cmd>GitGutterSignsToggle<cr>
nmap <silent> <leader>tj    <cmd>IlluminateToggle<cr>
nmap <silent> <leader>tj    <cmd>call ToggleFastEsc()<cr>
nmap <silent> <leader>tp    <cmd>setlocal paste!<cr>
nmap <silent> <leader>tr    <cmd>call rainbow_delimiters#toggle(0)<cr>
nmap <silent> <leader>ts    <cmd>setlocal spell!<cr>
nmap <silent> <leader>tw    <cmd>setlocal wrap!<cr>
" }}}

" editing {{{3
map <leader>S       :s/
nmap <leader>r      "_dwP
nmap <leader>xt     :Tabularize /
nmap <leader>xx     <cmd>s/ \+/\r/g<cr>
" }}}

" windows {{{3
nmap <leader>w=     <C-w>=
nmap <leader>wo     <cmd>tab sp<cr>
nmap <leader>wt     <C-w>T
nmap <leader>ww     <cmd>w<cr>

nmap <leader>xr     <cmd>so $MYVIMRC<cr>
nmap <leader>xv     <cmd>tabnew $MYVIMRC<cr>
" }}}

" fold (z) {{{3
nmap <leader>ze     <cmd>set foldmethod=expr<cr>
nmap <leader>zi     <cmd>set foldmethod=indent<cr>
nmap <leader>zm     <cmd>set foldmethod=manual<cr>
nmap <leader>zr     <cmd>set foldmethod=marker<cr>
nmap <leader>zz     <cmd>set foldmethod?<cr>
" }}}

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
    autocmd BufNewFile,BufRead  *.bb  setf clojure
    autocmd BufNewFile,BufRead  *.jte setf html
    autocmd BufWritePost        *.sync.py !jupytext -s %

    autocmd BufEnter    iced_stdout lua vim.diagnostic.enable(false, { bufnr = 0 })

augroup END

" }}}

highlight! link @variable   Normal
