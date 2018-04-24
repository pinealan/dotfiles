"===[ Plugin ]===
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'henrik/vim-indexed-search'
Plugin 'ap/vim-buftabline'

Plugin 'othree/html5.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'cespare/vim-toml'

Plugin 'Valloric/YouCompleteMe'

call vundle#end()

" reset vundle settings
filetype plugin on
filetype indent on
syntax on

" Dragvisuals
runtime plugin/dragvisuals.vim
vmap    <expr> <left>  DVB_Drag('left')
vmap    <expr> <right> DVB_Drag('right')
vmap    <expr> <down>  DVB_Drag('down')
vmap    <expr> <up>    DVB_Drag('up')
vmap    <expr> <D>     DVB_Duplicate()
vmap    <expr> <C-D>   DVB_Duplicate()

" NERDTree
augroup nerdtree_user
    autocmd!
    autocmd StdinReadPre * let s:std_in=1
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

let NERDTreeIgnore=['\.log$', '__pycache__', '\.pyc$', '.exe$', '\.png$', '\.jpg$', '\.jpeg$']
let NERDTreeStatusLine="%{matchstr(getline('.'),'\\s\\zs\\w\\(.*\\)')}"
let NERDTreeShowHidden=1

nnoremap  <c-e> :NERDTreeToggle<cr>

" YouCompleteMe
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

let g:ycm_error_symbol = 'x'
let g:ycm_warning_symbol = '>'
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_autoclose_preview_window_after_completion = 1

let g:ycm_global_ycm_extra_conf = "/home/alan/.vim/.ycm_extra_conf.py"
let g:ycm_confirm_extra_conf = 0
let g:ycm_filepath_completion_use_working_dir = 1
let g:ycm_extra_conf_vim_data = ['&filetype']
let g:ycm_python_binary_path = '/usr/bin/python3'

nnoremap <leader>0      :let g:ycm_auto_trigger=0<cr>
nnoremap <leader>1      :let g:ycm_auto_trigger=1<cr>

" BufTabLine
hi default link BufTabLineCurrent TabLineSel
hi default link BufTabLineActive TabLine
hi default link BufTabLineHidden TabLine
hi default link BufTabLineFill TabLineFill

let g:buftabline_numbers = 1


"===[ Color scheme ]===
colorscheme onedark

hi YcmErrorSection cterm=underline ctermfg=196
hi YcmWarningSection cterm=underline ctermfg=196


"===[ Syntax ]===
let g:python_no_doctest_highlight = 1
let g:python_no_builtin_highlight = 1

let g:tex_no_error = 1


"===[ UI/UX ]===
set backspace=eol,start,indent
set cursorline
set hidden
set history=500
set incsearch
set mouse=a
set noshowmatch
set number
set relativenumber
set whichwrap+=<,>,h,l


"===[ Statusline ]===
set laststatus=2
set statusline=
set statusline+=%#StatusLineGit#
set statusline+=%{StatusLineGit()}
set statusline+=%#User{1}#
set statusline+=\ %{HasPaste()}
set statusline+=%r%m%t
set statusline+=%=
set statusline+=%{GetCwd()}
set statusline+=\ %y
set statusline+=\ %l,\%-2c
set statusline+=\ \|%3p%%

function! HasPaste()
    if &paste
        return 'PASTE MODE'
    endif
    return ''
endfunction

function! GetCwd()
    let cwd=getcwd()
    let cwd=substitute(cwd, '/home/.\{-}/', '~/', '')
    let cwd=substitute(cwd, '[^~].*\(.\{25\}$\)\@=', '/...', '')
    let cwd=substitute(cwd, '\.\.\.[^/]*', '...', '')
    return cwd
endfunction

function! GitBranch()
    return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatusLineGit()
    let l:branchname=GitBranch()
    return strlen(l:branchname)>0?'  '.l:branchname.' ':''
endfunction


"===[ Tab, indent, wrap ]===
set autoindent
set smartindent
set smarttab
set expandtab
set shiftwidth=4
set softtabstop=-1

exec "set listchars=tab:\u2015\u2015,trail:\uB7"
set list

set colorcolumn=81
set formatoptions+=t
set textwidth=100
set wrap


"===[ Regex ]===
set ignorecase
set magic
set smartcase


"===[ Files, backups and undo ]===
set fileformat=unix
set fileencoding=utf8
set encoding=utf8
set nowritebackup
set noswapfile

" Trim trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e


"===[ File explorer (netrw) ]===
set path+=**
set wildmenu
set helpheight=35

let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_browse_split=1
let g:netrw_altv=1
let g:netrw_winsize=25
let g:netrw_sort_by='time'
let g:netrw_sort_direction='reverse'


"===[ Remap ]===
let mapleader=" "
noremap ; :
noremap : ;

" Homerow keys
noremap H 0
noremap J <c-e>
noremap K <c-y>
noremap L $

noremap $ J
noremap 0 K

inoremap jk         <esc>
inoremap kj         <esc>
inoremap JK         <esc>
inoremap KJ         <esc>

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

" Swap undo
noremap    U   <c-r>
noremap <c-r>     U

" Shortcut
noremap <tab>       :setlocal wrap!<cr>
noremap <s-tab>     :setlocal hlsearch!<cr>
noremap [h          <c-w>h
noremap [j          <c-w>j
noremap [k          <c-w>k
noremap [l          <c-w>l
noremap [<s-h>      <c-w>9<
noremap [<s-j>      <c-w>9-
noremap [<s-k>      <c-w>9+
noremap [<s-l>      <c-w>9>

nnoremap <cr>       o<esc>
nnoremap <c-s>      :update<cr>
nnoremap <c-q>      :q<cr>

nnoremap <c-l>      :bnext<cr>
nnoremap <c-h>      :bprev<cr>

nnoremap <c-n>      :cnext<cr>
nnoremap <c-p>      :cprev<cr>

nnoremap <c-j>      <c-x>
nnoremap <c-k>      <c-a>

nnoremap <leader>q      :bdelete<cr>
nnoremap <leader>m      :silent make \| redraw! \| cc<cr>
nnoremap <leader>e      :vsplit /home/alan/.vimrc<cr>
nnoremap <leader>s      :source /home/alan/.vimrc<cr>
nnoremap <leader><tab>  :call FastEsc()<cr>

noremap <F9>        :call EchoHighlightName()<cr>

function! EchoHighlightName()
    let id  = synID(line("."), col("."), 1)
    let tid = synID(line("."), col("."), 0)

    let fg  = synIDattr(synIDtrans(id), "fg")
    let bg  = synIDattr(synIDtrans(id), "bg")
    let hi  = synIDattr(id, "name")
    let lo  = synIDattr(synIDtrans(id), "name")
    let tr  = synIDattr(tid, "name")

    echo "hi: ".hi." \| lo: ".lo." \| trans: ".tr." \| fg: ".fg." \| bg: ".bg
endfunction

function! FastEsc()
    if mapcheck("jk", "i") ==? ""
        inoremap jk <esc>
        inoremap kj <esc>
        inoremap JK <esc>
        inoremap KJ <esc>
        echom "Enabled fast Esc"
    else
        iunmap jk
        iunmap kj
        iunmap JK
        iunmap KJ
        echom "Disabled fast Esc"
    endif
endfunction


"===[ Abbrevation ]===
" Common typos
iabbrev fro         for
iabbrev adn         and
iabbrev swithc      switch
iabbrev swihtc      switch
iabbrev siwthc      switch
iabbrev csae        case
iabbrev caes        case
