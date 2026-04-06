" Vim Color File
"
" Name:       one-dark.vim
" Maintainer: Alan Chan
" License:    The MIT License (MIT)
" Based On:   https://github.com/joshdick/onedark.vim/
" Based On:   https://github.com/MaxSt/FlatColor/

" [ Initialization ] {{{
"
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name="my-onelight"

" Helper function to match highlight gruops in all colors modes, i.e.
"   gui:      Full RGB, 24 bit
"   cterm:    256 color, 8 bit
"   term:     no color, (:h highlight-term)
"
function! s:h(group, style)
  execute "highlight" a:group
    \ "guifg="   (has_key(a:style, "fg")    ? a:style.fg.x24 : "NONE")
    \ "guibg="   (has_key(a:style, "bg")    ? a:style.bg.x24 : "NONE")
    \ "guisp="   (has_key(a:style, "sp")    ? a:style.sp     : "NONE")
    \ "gui="     (has_key(a:style, "gui")   ? a:style.gui    : "NONE")
    \ "ctermfg=" (has_key(a:style, "fg")    ? a:style.fg.x8  : "NONE")
    \ "ctermbg=" (has_key(a:style, "bg")    ? a:style.bg.x8  : "NONE")
    \ "cterm="   (has_key(a:style, "cterm") ? a:style.cterm  : "NONE")
endfunction
" }}}

" [ Color Variables ] {{{
"
let s:red           = { "x24": "#e45649", "x8": "166" }
let s:pink          = { "x24": "#ca1243", "x8": "160" }
let s:green         = { "x24": "#50a14f", "x8": "71" }
let s:teagreen      = { "x24": "#327002", "x8": "28" }
let s:teal          = { "x24": "#067682", "x8": "23" }
let s:yellow        = { "x24": "#d59201", "x8": "94" }
let s:gold          = { "x24": "#986801", "x8": "136" }
let s:carrot        = { "x24": "#eb814c", "x8": "173" }
let s:blue          = { "x24": "#046dc2", "x8": "33" }
let s:purple        = { "x24": "#981996", "x8": "127" }
let s:transparent   = { "x24": "NONE",    "x8": "NONE" }

" Semantic colors
let s:content0      = { "x24": "#292929", "x8": "16" }
let s:content1      = { "x24": "#606370", "x8": "60" }
let s:content2      = { "x24": "#999999", "x8": "145" }
let s:content_inv   = { "x24": "#c2c2c3", "x8": "250" }
let s:background0   = { "x24": "#fafafa", "x8": "255" }
let s:background1   = { "x24": "#dadada", "x8": "251" }
let s:background2   = { "x24": "#f0f0f0", "x8": "254" }
let s:_black        = { "x24": "#000000", "x8": "232" }
let s:_white        = { "x24": "#ffffff", "x8": "255" }

let s:docstring     = s:teagreen
let s:string        = s:teagreen
let s:macro         = s:carrot
let s:numeric       = s:carrot
let s:statement     = s:purple
let s:symbol        = s:pink
" }}}

" [ Syntax Groups (:h group-name) ] {{{
"
call s:h("Comment",         { "fg": s:teal, "gui": "italic" })
call s:h("Constant",        { "fg": s:numeric })
call s:h("String",          { "fg": s:string })
call s:h("Character",       { "fg": s:string })
call s:h("Number",          { "fg": s:numeric })
call s:h("Boolean",         { "fg": s:numeric })
call s:h("Float",           { "fg": s:numeric })

call s:h("Identifier",      { "fg": s:symbol })
call s:h("Function",        { "fg": s:blue })

call s:h("Statement",       { "fg": s:statement })
call s:h("Conditional",     { "fg": s:statement })
call s:h("Repeat",          { "fg": s:statement })
call s:h("Label",           { "fg": s:statement })
call s:h("Operator",        { "fg": s:statement })
call s:h("Keyword",         { "fg": s:statement })
call s:h("Exception",       { "fg": s:statement })

call s:h("PreProc",         { "fg": s:macro })
call s:h("Include",         { "fg": s:statement })
call s:h("Define",          { "fg": s:macro })
call s:h("Macro",           { "fg": s:macro })
call s:h("PreCondit",       { "fg": s:statement })

call s:h("Type",            { "fg": s:gold })
call s:h("StorageClass",    { "fg": s:yellow })
call s:h("Structure",       { "fg": s:statement })
call s:h("Typedef",         { "fg": s:statement })

call s:h("Special",         { "fg": s:content1 })
call s:h("SpecialChar",     { "fg": s:content1 })
call s:h("Tag",             { "fg": s:symbol })
call s:h("Delimiter",       { "fg": s:content2 })
call s:h("SpecialComment",  { "fg": s:string })
call s:h("Debug",           { "fg": s:content1 })

call s:h("Underlined",      { "gui": "underline", "cterm": "underline" })
call s:h("Ignore",          { "fg": s:content1 })
call s:h("Error",           { "fg": s:red })
call s:h("Todo",            { "fg": s:content1 })
" }}}

" [ Default Highlighting Groups (:h highlight-groups) ] {{{
"
call s:h("ColorColumn",     { "bg": s:background2 })
call s:h("Conceal",         {})
call s:h("Cursor",          { "fg": s:_black, "bg": s:blue })
call s:h("CursorIM",        {})
call s:h("CursorColumn",    { "bg": s:background2 })
call s:h("CursorLine",      { "bg": s:background2 })
call s:h("Directory",       { "fg": s:blue })

call s:h("DiffAdd",         { "bg": s:green, "fg": s:_black })
call s:h("DiffChange",      { "bg": s:gold, "fg": s:_black })
call s:h("DiffDelete",      { "bg": s:pink, "fg": s:_black })
call s:h("DiffText",        { "bg": s:_black, "fg": s:gold })

call s:h("ErrorMsg",        { "fg": s:pink })
call s:h("VertSplit",       { "fg": s:content2 })
call s:h("Folded",          { "fg": s:content2 })
call s:h("FoldColumn",      {})
call s:h("SignColumn",      {})
call s:h("IncSearch",       { "fg": s:yellow, "bg": s:content2 })
call s:h('LineNr',          { "fg": s:content_inv })
call s:h("CursorLineNr",    {})
call s:h("MatchParen",      { "fg": s:blue, "gui": "underline" })
call s:h("ModeMsg",         {})
call s:h("MoreMsg",         {})
call s:h("NonText",         { "fg": s:content2 })
call s:h("Normal",          { "fg": s:content0, "bg": s:background0 })

call s:h("Pmenu",           { "bg": s:background1 })
call s:h("PmenuSel",        { "fg": s:_black, "bg": s:blue })
call s:h("PmenuSbar",       { "bg": s:content0 })
call s:h("PmenuThumb",      { "bg": s:content0 })

call s:h("Question",        { "fg": s:purple })
call s:h("Search",          { "fg": s:_black, "bg": s:yellow })
call s:h("QuickFixLine",    { "fg": s:_black, "bg": s:gold })
call s:h("SpecialKey",      { "fg": s:content1 })

call s:h("SpellBad",        { "fg": s:symbol , "gui": "underline", "cterm": "underline" })
call s:h("SpellCap",        { "fg": s:carrot })
call s:h("SpellLocal",      { "fg": s:carrot })
call s:h("SpellRare",       { "fg": s:carrot })

call s:h("StatusLine",      { "fg": s:content0, "bg": s:background1 })
call s:h("StatusLineGit",   { "fg": s:_black, "bg": s:content2 })
call s:h("StatusLineNC",    { "fg": s:content2, "bg": s:_white })

call s:h("TabLine",         { "fg": s:content1 })
call s:h("TabLineFill",     { "fg": s:content1 })
call s:h("TabLineSel",      { "fg": s:content0 })

call s:h("Title",           { "fg": s:symbol })
call s:h("Visual",          { "bg": s:background1 })
call s:h("VisualNOS",       { "bg": s:background0 })
call s:h("WarningMsg",      { "fg": s:gold })
call s:h("WildMenu",        { "fg": s:_black, "bg": s:blue })
" }}}

" [ Python ] {{{
"
call s:h("pythonDocString", { "fg": s:docstring })
" }}}

" [ Git Highlighting ] {{{
"
call s:h("gitcommitComment",        { "fg": s:content2 })
call s:h("gitcommitUnmerged",       { "fg": s:teagreen })
call s:h("gitcommitOnBranch",       {})
call s:h("gitcommitBranch",         { "fg": s:purple })
call s:h("gitcommitDiscardedType",  { "fg": s:pink })
call s:h("gitcommitSelectedType",   { "fg": s:teagreen })
call s:h("gitcommitHeader",         {})
call s:h("gitcommitUntrackedFile",  { "fg": s:pink })
call s:h("gitcommitDiscardedFile",  { "fg": s:red })
call s:h("gitcommitSelectedFile",   { "fg": s:green })
call s:h("gitcommitUnmergedFile",   { "fg": s:gold })
call s:h("gitcommitFile",           {})
call s:h("gitcommitSummary",        { "fg": s:content0 })
call s:h("gitcommitOverflow",       { "fg": s:pink })
hi link gitcommitNoBranch gitcommitBranch
hi link gitcommitUntracked gitcommitComment
hi link gitcommitDiscarded gitcommitComment
hi link gitcommitSelected gitcommitComment
hi link gitcommitDiscardedArrow gitcommitDiscardedFile
hi link gitcommitSelectedArrow gitcommitSelectedFile
hi link gitcommitUnmergedArrow gitcommitUnmergedFile
" }}}

" [ Plugin Highlighting ] {{{
"
" airblade/vim-gitgutter
hi link GitGutterAdd    SignifySignAdd
hi link GitGutterChange SignifySignChange
hi link GitGutterDelete SignifySignDelete

" mhinz/vim-signify
call s:h("SignifySignAdd",          { "fg": s:teagreen })
call s:h("SignifySignChange",       { "fg": s:gold })
call s:h("SignifySignDelete",       { "fg": s:pink })

" neomake/neomake
call s:h("NeomakeWarningSign",      { "fg": s:gold })
call s:h("NeomakeErrorSign",        { "fg": s:pink })
call s:h("NeomakeInfoSign",         { "fg": s:blue })

" tpope/vim-fugitive
call s:h("diffAdded",               { "fg": s:teagreen })
call s:h("diffRemoved",             { "fg": s:pink })

" RRethy/vim-illuminate
call s:h("IlluminatedWordText",     { "bg": s:background1, "gui": "underline" })
call s:h("IlluminatedWordRead",     { "bg": s:background1, "gui": "underline" })
call s:h("IlluminatedWordWrite",    { "bg": s:background1, "gui": "italic" })
" }}}

" [ Neovim terminal colors ] {{{
"
"if has("nvim")
"  let g:terminal_color_0 =  s:black.gui
"  let g:terminal_color_1 =  s:pink.gui
"  let g:terminal_color_2 =  s:teagreen.gui
"  let g:terminal_color_3 =  s:gold.gui
"  let g:terminal_color_4 =  s:blue.gui
"  let g:terminal_color_5 =  s:purple.gui
"  let g:terminal_color_6 =  s:cyan.gui
"  let g:terminal_color_7 =  s:whitesmoke.gui
"  let g:terminal_color_8 =  s:visual.gui
"  let g:terminal_color_9 =  s:red.gui
"  let g:terminal_color_10 = s:teagreen.gui " No dark version
"  let g:terminal_color_11 = s:carrot.gui
"  let g:terminal_color_12 = s:blue.gui " No dark version
"  let g:terminal_color_13 = s:purple.gui " No dark version
"  let g:terminal_color_14 = s:cyan.gui " No dark version
"  let g:terminal_color_15 = s:comment.gui
"  let g:terminal_color_background = g:terminal_color_0
"  let g:terminal_color_foreground = g:terminal_color_7
"endif
" }}}

" Must appear at the end of the file to work around this oddity:
" https://groups.google.com/forum/#!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
set background=light
