"===[ Plugin ]===
filetype off
set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'
" NERDTree {{{
augroup nerdtree_user
    autocmd!
    autocmd StdinReadPre * let s:std_in=1
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

let NERDTreeIgnore=['\.log$', '__pycache__', '\.pyc$', '.exe$', '\.png$', '\.jpg$', '\.jpeg$']
let NERDTreeStatusLine="%{matchstr(getline('.'),'\\s\\zs\\w\\(.*\\)')}"
let NERDTreeShowHidden=1

nnoremap  <c-e> :NERDTreeToggle<cr>
" }}}
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'henrik/vim-indexed-search'
Plugin 'ap/vim-buftabline'
" BufTabLine {{{
hi default link BufTabLineCurrent TabLineSel
hi default link BufTabLineActive TabLine
hi default link BufTabLineHidden TabLine
hi default link BufTabLineFill TabLineFill

let g:buftabline_numbers = 1
" }}}
Plugin 'godlygeek/tabular'
" Tabularize {{{{{{{{{
noremap <leader>=   :Tabularize /=<cr>
noremap <leader>\   :Tabularize /\|<cr>
" }}}}}}}}}
Plugin 'othree/html5.vim'
" HTML5 {{{
let g:html_exclude_tags = ['html', 'body', 'head']
" }}}
Plugin 'leafgarland/typescript-vim'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'cespare/vim-toml'
Plugin 'Valloric/YouCompleteMe'
" YouCompleteMe {{{
let g:ycm_min_num_of_chars_for_completion = 3
let g:ycm_max_num_candidates = 25
let g:ycm_filetype_blacklist = {
    \ 'tagbar': 1,
    \ 'qf': 1,
    \ 'notes': 1,
    \ 'markdown': 1,
    \ 'unite': 1,
    \ 'text': 1,
    \ 'vimwiki': 1,
    \ 'pandoc': 1,
    \ 'infolog': 1,
    \ 'mail': 1,
    \ 'html': 1,
    \ 'gitconfig': 1,
    \ 'tex': 1,
    \ 'bib': 0,
    \}

" YCM diagnostic
hi YcmErrorSection cterm=underline ctermfg=196
hi YcmWarningSection cterm=underline ctermfg=196

let g:ycm_error_symbol = 'x'
let g:ycm_warning_symbol = '>'
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_autoclose_preview_window_after_completion = 1

" YCM paths
let g:ycm_global_ycm_extra_conf = "/home/alan/.vim/.ycm_extra_conf.py"
let g:ycm_confirm_extra_conf = 0
let g:ycm_filepath_completion_use_working_dir = 1
let g:ycm_extra_conf_vim_data = ['&filetype']
let g:ycm_python_binary_path = '/usr/bin/python3'

nnoremap <leader>0      :let g:ycm_auto_trigger=0<cr>
nnoremap <leader>1      :let g:ycm_auto_trigger=1<cr>
" }}}

call vundle#end()
filetype plugin indent on
syntax on


"===[ Color scheme ]===
colorscheme onedark
set background=dark


"===[ Default Syntax Package Options ]===
let g:python_no_doctest_highlight = 1
let g:python_no_builtin_highlight = 1

let g:tex_no_error = 1


"===[ Options ]===
set backspace=eol,start,indent
set cursorline
set hidden
set history=500
set hlsearch
set incsearch
set lazyredraw
set mouse=a
set noshowmatch
set number
set relativenumber
set scrolloff=7
set whichwrap+=<,>,h,l

set laststatus=2
set statusline=%#StatusLineGit#%{GitBranch()}%#User{1}#\ %{HasPaste()}%r%m%t%=%{ShortCwd()}\ %y\ %l,\%-2c\ \|%3p%%

set splitright

" Tab, indent, wrap
set smarttab
set shiftwidth=4
set softtabstop=-1

set autoindent
set smartindent
set expandtab
set list
exec "set listchars=tab:\u2015\u2015,trail:\uB7"

set colorcolumn=81
set formatoptions+=t
set textwidth=100
set wrap

" Regex
set ignorecase
set magic
set smartcase

" Files, backups and undo
set fileformat=unix
set fileencoding=utf8
set encoding=utf8
set nowritebackup
set noswapfile

" Trim trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Command-line completion
set path+=**
set wildmenu
set wildignore=__pycache__,*.o,*.pyc,*.git,*.exe
set helpheight=30


"===[ Mapping ]===
let mapleader=" "

" Thank me later
noremap ; :
noremap : ;

" Homerow navigation
noremap H 0
noremap J L
noremap K H
noremap L $
noremap <c-j> <c-d>
noremap <c-k> <c-u>

noremap $ J
noremap 0 K

" Fast <esc>
inoremap jk     <esc>
inoremap kj     <esc>

" Swap undo
noremap    U   <c-r>
noremap <c-r>     U

" Windows navigation
noremap [h          <c-w>h
noremap [j          <c-w>j
noremap [k          <c-w>k
noremap [l          <c-w>l
noremap [<s-h>      <c-w>9<
noremap [<s-j>      <c-w>9-
noremap [<s-k>      <c-w>9+
noremap [<s-l>      <c-w>9>

" Buffer/Error list shortcuts
noremap <c-s>      :update<cr>
noremap <c-q>      :q<cr>
noremap <c-l>      :bnext<cr>
noremap <c-h>      :bprev<cr>
noremap <c-n>      :cnext<cr>
noremap <c-p>      :cprev<cr>

" Normal mode command shortchuts
nnoremap <cr>               o<esc>
nnoremap <tab>              :setlocal wrap!<cr>
nnoremap <leader>s          :setlocal spell!<cr>
nnoremap <leader>w          :w !sudo tee % > /dev/null
nnoremap <leader><tab>      :call ToggleFastEsc()<cr>
nnoremap <leader><leader>   :setlocal hlsearch!<cr>

nnoremap <silent> -             :call Underline('-')<cr>
nnoremap <silent> =             :call Underline('=')<cr>
nnoremap <silent> <leader>h     :echo HighlightName()<cr>
nnoremap <silent> <leader>d     :bdelete<cr>
nnoremap <silent> <leader>m     :silent make \| redraw! \| cc<cr>
nnoremap <silent> <leader>n     :vnew \| set ft=markdown<cr>
nnoremap <silent> <leader>e     :vsplit /home/alan/.vimrc<cr>
nnoremap <silent> <leader>p     :setlocal paste!<cr>

" Fix tmux
noremap     <esc>OA     <up>
noremap     <esc>OB     <down>
noremap     <esc>OD     <left>
noremap     <esc>OC     <right>
noremap!    <esc>OA     <up>
noremap!    <esc>OB     <down>
noremap!    <esc>OD     <left>
noremap!    <esc>OC     <right>
noremap!    <esc>[3~    <del>


"===[ Abbrevation ]===
" Common typos
iabbrev fro         for
iabbrev adn         and
iabbrev swithc      switch
iabbrev swihtc      switch
iabbrev siwthc      switch
iabbrev csae        case
iabbrev caes        case


"===[ Helper functions]===
function! HasPaste()
    if &paste
        return 'PASTE MODE'
    endif
    return ''
endfunction

function! ShortCwd()
    let cwd=getcwd()
    let cwd=substitute(cwd, '/home/.\{-}/', '~/', '')
    let cwd=substitute(cwd, '[^~].*\(.\{25\}$\)\@=', '/...', '')
    let cwd=substitute(cwd, '\.\.\.[^/]*', '...', '')
    return cwd
endfunction

function! GitBranch()
    let l:branchname = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
    return strlen(l:branchname) > 0 ? '  '.l:branchname.' ' : ''
endfunction

function! HighlightName()
    let id  = synID(line("."), col("."), 1)
    let tid = synID(line("."), col("."), 0)

    let fg  = synIDattr(synIDtrans(id), "fg")
    let bg  = synIDattr(synIDtrans(id), "bg")
    let hi  = synIDattr(id, "name")
    let lo  = synIDattr(synIDtrans(id), "name")
    let tr  = synIDattr(tid, "name")

    return "hi: ".hi." \| lo: ".lo." \| trans: ".tr." \| fg: ".fg." \| bg: ".bg
endfunction

function! ToggleFastEsc()
    if mapcheck("jk", "i") ==? ""
        inoremap jk <esc>
        inoremap kj <esc>
        echom "Enabled fast Esc"
    else
        iunmap jk
        iunmap kj
        echom "Disabled fast Esc"
    endif
endfunction

function! Underline(symbol)
    if strlen(getline('.')) > 0
        normal! yyp
        exe 's/./' . a:symbol . '/g'
        normal! k
    endif
endfunction

" vim: foldmethod=marker
