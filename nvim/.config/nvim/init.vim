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
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'zirrostig/vim-schlepp'

Plug 'jiangmiao/auto-pairs'
Plug '/nix/store/3zc8kjdicrkwlby25dajz3d6bjrdwq08-fzf-0.55.0/share/vim-plugins/fzf'
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vim-which-key'
Plug 'RRethy/vim-illuminate'
Plug 'luochen1990/rainbow'
Plug 'gyim/vim-boxdraw'

"Plug 'nvim-treesitter/nvim-treesitter'
"Plug 'nvim-treesitter/playground'

Plug 'kana/vim-textobj-user'

" Languages
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'jeetsukumaran/vim-pythonsense'
"Plug 'lepture/vim-jinja'

Plug 'guns/vim-sexp', { 'for': ['clojure', 'scheme', 'lisp', 'timl'] }
Plug '~/src/vim-iced', { 'for': 'clojure' }

Plug 'eigenfoo/stan-vim'
Plug 'vyperlang/vim-vyper'

" Polyglot {{{

let g:polyglot_disabled = ['clojure', 'markdown', 'python', 'solidity']

" }}}

Plug 'sheerun/vim-polyglot'

" Git Gutter {{{

let g:gitgutter_map_keys = 0
let g:gitgutter_preview_win_floating = 1

" }}}
" YouCompleteMe {{{

let g:ycm_min_num_of_chars_for_completion = 2
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
let g:ycm_use_ultisnips_completer = 1

" YCM diagnostic
hi YcmErrorSection cterm=underline ctermfg=196
hi YcmWarningSection cterm=underline ctermfg=196
let g:ycm_error_symbol = 'x'
let g:ycm_warning_symbol = '>'
let g:ycm_open_loclist_on_ycm_diags = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_autoclose_preview_window_after_completion = 1

" YCM paths
let g:ycm_confirm_extra_conf = 0
let g:ycm_filepath_completion_use_working_dir = 1
let g:ycm_extra_conf_vim_data = ['&filetype']

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

" illuminate {{{

lua require('illuminate').configure({ delay = 50, })

" }}}

" }}}

source ~/.vim/vimrc
set termguicolors
"lua require('init')
