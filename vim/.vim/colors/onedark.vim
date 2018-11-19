" Vim Color File
"
" Name:       one-dark.vim
" Maintainer: Alan Chan
" License:    The MIT License (MIT)
" Based On:   https://github.com/joshdick/onedark.vim/
" Based On:   https://github.com/MaxSt/FlatColor/
" @note: GUI colors are not configured

" [ Initialization ] {{{
"
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name="onedark"

" Helper function to match highlight gruops in all colors modes, i.e.
"   gui:      Full RGB, 24 bit
"   cterm:    256 color, 8 bit
"   term:     no color, (:h highlight-term)
"
" @Note: It's 2018, I don't care about term and cterm16.
"
function! s:h(group, style)
  execute "highlight" a:group
    \ "guifg="   (has_key(a:style, "fg")    ? a:style.fg.gui   : "NONE")
    \ "ctermfg=" (has_key(a:style, "fg")    ? a:style.fg.cterm : "NONE")
    \ "guibg="   (has_key(a:style, "bg")    ? a:style.bg.gui   : "NONE")
    \ "ctermbg=" (has_key(a:style, "bg")    ? a:style.bg.cterm : "NONE")
    \ "guisp="   (has_key(a:style, "sp")    ? a:style.sp       : "NONE")
    \ "gui="     (has_key(a:style, "gui")   ? a:style.gui      : "NONE")
    \ "cterm="   (has_key(a:style, "cterm") ? a:style.cterm    : "NONE")
endfunction
" }}}

" [ Color Variables ] {{{
"
let s:red           = { "gui": "#be5046", "cterm": "160" }
let s:pink          = { "gui": "#e06c75", "cterm": "204" }
let s:green         = { "gui": "#98c379", "cterm": "70" }
let s:teagreen      = { "gui": "#98c379", "cterm": "114" }
let s:teal          = { "gui": "#61afef", "cterm": "30" }
let s:yellow        = { "gui": "#e5c07b", "cterm": "220" }
let s:gold          = { "gui": "#e5c07b", "cterm": "179" }
let s:carrot        = { "gui": "#d19a66", "cterm": "173" }
let s:blue          = { "gui": "#61afef", "cterm": "75" }
let s:purple        = { "gui": "#c678dd", "cterm": "170" }

let s:transparent   = { "gui": "NONE",    "cterm": "NONE" }
let s:content0      = { "gui": "#bbc2cf", "cterm": "253" }
let s:content1      = { "gui": "#abb2bf", "cterm": "246" }
let s:content2      = { "gui": "#abb2bf", "cterm": "241" }
let s:background0   = { "gui": "#3e4452", "cterm": "237" }
let s:background1   = { "gui": "#bbc2cf", "cterm": "235" }
let s:background2   = { "gui": "#bbc2cf", "cterm": "234" }
let s:black         = { "gui": "#bbc2cf", "cterm": "232" }

let s:string        = s:teagreen
let s:numeric       = s:carrot
let s:statement     = s:purple
" }}}

" [ Syntax Groups (:h group-name) ] {{{
"
call s:h("Comment",         { "fg": s:teal, "gui": "italic" }) " any comment
call s:h("Constant",        { "fg": s:numeric }) " any constant
call s:h("String",          { "fg": s:string }) " a string constant: 'this is a string'
call s:h("Character",       { "fg": s:string }) " a character constant: 'c', '\n'
call s:h("Number",          { "fg": s:numeric }) " a number constant: 234, 0xff
call s:h("Boolean",         { "fg": s:numeric }) " a boolean constant: TRUE, false
call s:h("Float",           { "fg": s:numeric }) " a floating point constant: 2.3e10

call s:h("Identifier",      { "fg": s:pink }) " any variable name
call s:h("Function",        { "fg": s:blue }) " function name (also: methods for classes)

call s:h("Statement",       { "fg": s:statement })  " any statement
call s:h("Conditional",     { "fg": s:statement })  " if, then, else, endif, switch, etc.
call s:h("Repeat",          { "fg": s:statement })  " for, do, while, etc.
call s:h("Label",           { "fg": s:statement })  " case, default, etc.
call s:h("Operator",        { "fg": s:statement })  " sizeof, +, *, etc.
call s:h("Keyword",         { "fg": s:statement })       " any other statement
call s:h("Exception",       { "fg": s:statement })  " try, catch, throw

call s:h("PreProc",         { "fg": s:gold }) " generic Preprocessor
call s:h("Include",         { "fg": s:statement }) " preprocessor #include
call s:h("Define",          { "fg": s:blue }) " preprocessor #define
call s:h("Macro",           { "fg": s:blue }) " same as Define
call s:h("PreCondit",       { "fg": s:statement }) " preprocessor #if, #else, #endif, etc.

call s:h("Type",            { "fg": s:gold }) " int, long, char, etc.
call s:h("StorageClass",    { "fg": s:statement }) " static, register, volatile, etc.
call s:h("Structure",       { "fg": s:statement }) " struct, union, enum, etc.
call s:h("Typedef",         { "fg": s:statement }) " A typedef

call s:h("Special",         { "fg": s:content1 }) " any special symbol
call s:h("SpecialChar",     { "fg": s:content1 }) " special character in a constant
call s:h("Tag",             { "fg": s:pink }) " you can use CTRL-] on this
call s:h("Delimiter",       { "fg": s:content1 }) " character that needs attention
call s:h("SpecialComment",  { "fg": s:string }) " special things inside a comment
call s:h("Debug",           { "fg": s:content1 }) " debugging statements

call s:h("Underlined",      { "gui": "underline", "cterm": "underline" }) " text that stands out, HTML links
call s:h("Ignore",          { "fg": s:pink }) " left blank, hidden
call s:h("Error",           { "fg": s:red }) " any erroneous construct
call s:h("Todo",            { "fg": s:content1 }) " TODO anything that needs extra attention; mostly the keywords TODO FIXME and XXX
" }}}

" [ Default Highlighting Groups (:h highlight-groups) ] {{{
"
call s:h("ColorColumn",     { "bg": s:background2 }) " used for the columns set with 'colorcolumn'
call s:h("Conceal",         {}) " placeholder characters substituted for concealed text (see 'conceallevel')
call s:h("Cursor",          { "fg": s:black, "bg": s:blue }) " the character under the cursor
call s:h("CursorIM",        {}) " like Cursor, but used when in IME mode
call s:h("CursorColumn",    { "bg": s:background2 }) " the screen column that the cursor is in when 'cursorcolumn' is set
call s:h("CursorLine",      { "bg": s:background2 }) " the screen line that the cursor is in when 'cursorline' is set
call s:h("Directory",       { "fg": s:blue }) " directory names (and other special names in listings)

call s:h("DiffAdd",         { "bg": s:green, "fg": s:black }) " diff mode: Added line
call s:h("DiffChange",      { "bg": s:gold, "fg": s:black }) " diff mode: Changed line
call s:h("DiffDelete",      { "bg": s:pink, "fg": s:black }) " diff mode: Deleted line
call s:h("DiffText",        { "bg": s:black, "fg": s:gold }) " diff mode: Changed text within a changed line

call s:h("ErrorMsg",        { "fg": s:pink }) " error messages on the command line
call s:h("VertSplit",       { "fg": s:content2 }) " the column separating vertically split windows
call s:h("Folded",          { "fg": s:content2 }) " line used for closed folds
call s:h("FoldColumn",      {}) " 'foldcolumn'
call s:h("SignColumn",      {}) " column where signs are displayed
call s:h("IncSearch",       { "fg": s:yellow, "bg": s:content2 }) " 'incsearch' highlighting; also used for the text replaced with ':s///c'
call s:h("LineNr",          { "fg": s:background0 }) " Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
call s:h("CursorLineNr",    {}) " Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
call s:h("MatchParen",      { "fg": s:blue, "gui": "underline" }) " The character under the cursor or just before it, if it is a paired bracket, and its match.
call s:h("ModeMsg",         {}) " 'showmode' message (e.g., -- INSERT --)
call s:h("MoreMsg",         {}) " more-prompt
call s:h("NonText",         { "fg": s:background0 }) " '~' and '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., '>' displayed when a double-wide character doesn't fit at the end of the line).
call s:h("Normal",          { "fg": s:content0, "bg": s:background1  }) " normal text

call s:h("Pmenu",           { "bg": s:background0 }) " Popup menu: normal item.
call s:h("PmenuSel",        { "fg": s:black, "bg": s:blue }) " Popup menu: selected item.
call s:h("PmenuSbar",       { "bg": s:content0 }) " Popup menu: scrollbar.
call s:h("PmenuThumb",      { "bg": s:content0 }) " Popup menu: Thumb of the scrollbar.

call s:h("Question",        { "fg": s:purple }) " hit-enter prompt and yes/no questions
call s:h("Search",          { "fg": s:black, "bg": s:yellow }) " Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
call s:h("QuickFixLine",    { "fg": s:black, "bg": s:gold }) " Current quickfix item in the quickfix window.
call s:h("SpecialKey",      { "fg": s:background1 }) " Meta and special keys listed with ':map', also for text used to show unprintable characters in the text, 'listchars'. Generally: text that is displayed differently from what it really is.

call s:h("SpellBad",        { "fg": s:pink, "gui": "underline", "cterm": "underline" }) " Word that is not recognized by the spellchecker. This will be combined with the highlighting used otherwise.
call s:h("SpellCap",        { "fg": s:carrot }) " Word that should start with a capital. This will be combined with the highlighting used otherwise.
call s:h("SpellLocal",      { "fg": s:carrot }) " Word that is recognized by the spellchecker as one that is used in another region. This will be combined with the highlighting used otherwise.
call s:h("SpellRare",       { "fg": s:carrot }) " Word that is recognized by the spellchecker as one that is hardly ever used. spell This will be combined with the highlighting used otherwise.

call s:h("StatusLine",      { "fg": s:content0, "bg": s:background0 }) " status line of current window
call s:h("StatusLineGit",   { "fg": s:black, "bg": s:content2 }) " status line of current window
call s:h("StatusLineNC",    { "fg": s:content2, "bg": s:black }) " status lines of not-current windows Note: if this is equal to 'StatusLine' Vim will use '^^^' in the status line of the current window.

call s:h("TabLine",         { "fg": s:content2 }) " tab pages line, not active tab page label
call s:h("TabLineFill",     { "fg": s:content1 }) " tab pages line, where there are no labels
call s:h("TabLineSel",      { "fg": s:content0 }) " tab pages line, active tab page label

call s:h("Title",           { "fg": s:pink }) " titles for output from ':set all', ':autocmd' etc.
call s:h("Visual",          { "bg": s:background0 }) " Visual mode selection
call s:h("VisualNOS",       { "bg": s:background1 }) " Visual mode selection when vim is 'Not Owning the Selection'. Only X11 Gui's gui-x11 and xterm-clipboard supports this.
call s:h("WarningMsg",      { "fg": s:gold }) " warning messages
call s:h("WildMenu",        { "fg": s:black, "bg": s:blue }) " current match in 'wildmenu' completion
" }}}

" [ Python ] {{{
"
call s:h("pythonDocString", { "fg": { "gui": "#98c379", "cterm": "34" } })
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
set background=dark
