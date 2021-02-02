syn keyword htmlTagID   class id

hi def link htmlTag         Delimiter
hi def link htmlEndTag      Delimiter
hi def link htmlTagName     Identifier

hi def link htmlTagID       Function

hi def link htmlBold                Normal
hi def link htmlBoldUnderline       Normal
hi def link htmlBoldItalic          Normal
hi def link htmlBoldUnderlineItalic Normal
hi def link htmlUnderline           Normal
hi def link htmlUnderlineItalic     Normal
hi def link htmlItalic              Normal
hi def link htmlH1                  Normal
hi def link htmlH2                  Normal
hi def link htmlH3                  Normal
hi def link htmlH4                  Normal
hi def link htmlH5                  Normal
hi def link htmlH6                  Normal
hi def link htmlTitle               Normal

" call matchadd('htmlTagID', '\<\(class\|id\)\>\ze=')
