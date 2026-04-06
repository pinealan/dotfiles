" Vim Color File

" [ Helpers ] {{{
" Match a highlight gruop in all colors modes, i.e.
"   gui:      Full RGB, 24 bit
"   cterm:    256 color, 8 bit
"   term:     no color, (:h highlight-term)
"
function! onecolor#set(group, style)
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

function! onecolor#set_all(colors)
    " [ Syntax Groups (:h group-name) ] {{{
    "
    call onecolor#set("Comment",         { "fg": a:colors.teagreen })
    call onecolor#set("Constant",        { "fg": a:colors.numeric })
    call onecolor#set("String",          { "fg": a:colors.teal })
    call onecolor#set("Character",       { "fg": a:colors.teal })
    call onecolor#set("Number",          { "fg": a:colors.numeric })
    call onecolor#set("Boolean",         { "fg": a:colors.numeric })
    call onecolor#set("Float",           { "fg": a:colors.numeric })

    call onecolor#set("Identifier",      { "fg": a:colors.symbol })
    call onecolor#set("Function",        { "fg": a:colors.blue })

    call onecolor#set("Statement",       { "fg": a:colors.statement })
    call onecolor#set("Conditional",     { "fg": a:colors.statement })
    call onecolor#set("Repeat",          { "fg": a:colors.statement })
    call onecolor#set("Label",           { "fg": a:colors.statement })
    call onecolor#set("Operator",        { "fg": a:colors.statement })
    call onecolor#set("Keyword",         { "fg": a:colors.statement })
    call onecolor#set("Exception",       { "fg": a:colors.statement })

    call onecolor#set("PreProc",         { "fg": a:colors.macro })
    call onecolor#set("Include",         { "fg": a:colors.statement })
    call onecolor#set("Define",          { "fg": a:colors.macro })
    call onecolor#set("Macro",           { "fg": a:colors.macro })
    call onecolor#set("PreCondit",       { "fg": a:colors.statement })

    call onecolor#set("Type",            { "fg": a:colors.gold })
    call onecolor#set("StorageClass",    { "fg": a:colors.yellow })
    call onecolor#set("Structure",       { "fg": a:colors.statement })
    call onecolor#set("Typedef",         { "fg": a:colors.statement })

    call onecolor#set("Special",         { "fg": a:colors.content1 })
    call onecolor#set("SpecialChar",     { "fg": a:colors.content1 })
    call onecolor#set("Tag",             { "fg": a:colors.symbol })
    call onecolor#set("Delimiter",       { "fg": a:colors.content2 })
    call onecolor#set("SpecialComment",  { "fg": a:colors.teal })
    call onecolor#set("Debug",           { "fg": a:colors.content1 })

    call onecolor#set("Underlined",      { "gui": "underline", "cterm": "underline" })
    call onecolor#set("Ignore",          { "fg": a:colors.content1 })
    call onecolor#set("Error",           { "fg": a:colors.red })
    call onecolor#set("Todo",            { "fg": a:colors.content1 })
    " }}}

    " [ Default Highlighting Groups (:h highlight-groups) ] {{{
    "
    call onecolor#set("ColorColumn",     { "bg": a:colors.background1 })
    call onecolor#set("Conceal",         {})
    call onecolor#set("Cursor",          { "fg": a:colors.black, "bg": a:colors.blue })
    call onecolor#set("CursorIM",        {})
    call onecolor#set("CursorColumn",    { "bg": a:colors.background1 })
    call onecolor#set("CursorLine",      { "bg": a:colors.background1 })
    call onecolor#set("Directory",       { "fg": a:colors.blue })

    call onecolor#set("DiffAdd",         { "bg": a:colors.green, "fg": a:colors.black })
    call onecolor#set("DiffChange",      { "bg": a:colors.gold, "fg": a:colors.black })
    call onecolor#set("DiffDelete",      { "bg": a:colors.pink, "fg": a:colors.black })
    call onecolor#set("DiffText",        { "bg": a:colors.black, "fg": a:colors.gold })

    call onecolor#set("ErrorMsg",        { "fg": a:colors.pink })
    call onecolor#set("VertSplit",       { "fg": a:colors.content2 })
    call onecolor#set("Folded",          { "fg": a:colors.content2 })
    call onecolor#set("FoldColumn",      {})
    call onecolor#set("SignColumn",      {})
    call onecolor#set("IncSearch",       { "fg": a:colors.yellow, "bg": a:colors.content2 })
    call onecolor#set('LineNr',          { "fg": a:colors.content_inv })
    call onecolor#set("CursorLineNr",    { "fg": a:colors.content2})
    call onecolor#set("MatchParen",      { "fg": a:colors.blue, "gui": "underline" })
    call onecolor#set("ModeMsg",         {})
    call onecolor#set("MoreMsg",         {})
    call onecolor#set("NonText",         { "fg": a:colors.content2 })
    call onecolor#set("Normal",          { "fg": a:colors.content0, "bg": a:colors.background0 })

    call onecolor#set("Pmenu",           { "bg": a:colors.background_2 })
    call onecolor#set("PmenuSel",        { "bg": a:colors.blue, "fg": a:colors.black })
    call onecolor#set("PmenuSbar",       { "bg": a:colors.content0 })
    call onecolor#set("PmenuThumb",      { "bg": a:colors.content0 })

    call onecolor#set("Question",        { "fg": a:colors.purple })
    call onecolor#set("QuickFixLine",    { "bg": a:colors.background2 })
    call onecolor#set("Search",          { "fg": a:colors.black, "bg": a:colors.yellow })
    call onecolor#set("SpecialKey",      { "fg": a:colors.content1 })

    call onecolor#set("SpellBad",        { "fg": a:colors.red , "gui": "underline", "cterm": "underline" })
    call onecolor#set("SpellCap",        { "fg": a:colors.carrot })
    call onecolor#set("SpellLocal",      { "fg": a:colors.carrot })
    call onecolor#set("SpellRare",       { "fg": a:colors.carrot })

    call onecolor#set("StatusLine",      { "bg": a:colors.background_1, "fg": a:colors.content0 })
    call onecolor#set("StatusLineGit",   { "bg": a:colors.content2, "fg": a:colors.black })
    call onecolor#set("StatusLineNC",    { "bg": a:colors.background2, "fg": a:colors.content2 })

    call onecolor#set("TabLine",         { "fg": a:colors.content1 })
    call onecolor#set("TabLineFill",     { "fg": a:colors.content1 })
    call onecolor#set("TabLineSel",      { "fg": a:colors.content0 })

    call onecolor#set("Title",           { "fg": a:colors.symbol })
    call onecolor#set("Visual",          { "bg": a:colors.background_2 })
    call onecolor#set("VisualNOS",       { "bg": a:colors.background0 })
    call onecolor#set("WarningMsg",      { "fg": a:colors.gold })
    call onecolor#set("WildMenu",        { "fg": a:colors.black, "bg": a:colors.blue })
    " }}}

    " [ Git Highlighting ] {{{
    "
    call onecolor#set("gitcommitComment",        { "fg": a:colors.content2 })
    call onecolor#set("gitcommitUnmerged",       { "fg": a:colors.teagreen })
    call onecolor#set("gitcommitOnBranch",       {})
    call onecolor#set("gitcommitBranch",         { "fg": a:colors.purple })
    call onecolor#set("gitcommitDiscardedType",  { "fg": a:colors.pink })
    call onecolor#set("gitcommitSelectedType",   { "fg": a:colors.teagreen })
    call onecolor#set("gitcommitHeader",         {})
    call onecolor#set("gitcommitUntrackedFile",  { "fg": a:colors.pink })
    call onecolor#set("gitcommitDiscardedFile",  { "fg": a:colors.red })
    call onecolor#set("gitcommitSelectedFile",   { "fg": a:colors.green })
    call onecolor#set("gitcommitUnmergedFile",   { "fg": a:colors.gold })
    call onecolor#set("gitcommitFile",           {})
    call onecolor#set("gitcommitSummary",        { "fg": a:colors.content0 })
    call onecolor#set("gitcommitOverflow",       { "fg": a:colors.pink })
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
    call onecolor#set("SignifySignAdd",          { "fg": a:colors.teagreen })
    call onecolor#set("SignifySignChange",       { "fg": a:colors.gold })
    call onecolor#set("SignifySignDelete",       { "fg": a:colors.pink })

    " neomake/neomake
    call onecolor#set("NeomakeWarningSign",      { "fg": a:colors.gold })
    call onecolor#set("NeomakeErrorSign",        { "fg": a:colors.pink })
    call onecolor#set("NeomakeInfoSign",         { "fg": a:colors.blue })

    " tpope/vim-fugitive
    call onecolor#set("diffAdded",               { "fg": a:colors.teagreen })
    call onecolor#set("diffRemoved",             { "fg": a:colors.pink })

    " RRethy/vim-illuminate
    call onecolor#set("IlluminatedWordText",     { "bg": a:colors.background_2, "gui": "underline" })
    call onecolor#set("IlluminatedWordRead",     { "bg": a:colors.background_2, "gui": "underline" })
    call onecolor#set("IlluminatedWordWrite",    { "bg": a:colors.background_2, "gui": "italic" })
    " }}}
endfunction
