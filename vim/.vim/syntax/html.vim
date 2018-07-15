syn keyword htmlTagID   class id

hi link htmlTag         Delimiter
hi link htmlEndTag      Delimiter
hi link htmlTagName     Identifier

hi link htmlTagID       Function

hi link htmlBold                Normal
hi link htmlBoldUnderline       Normal
hi link htmlBoldItalic          Normal
hi link htmlBoldUnderlineItalic Normal
hi link htmlUnderline           Normal
hi link htmlUnderlineItalic     Normal
hi link htmlItalic              Normal
hi link htmlH1                  Normal
hi link htmlH2                  Normal
hi link htmlH3                  Normal
hi link htmlH4                  Normal
hi link htmlH5                  Normal
hi link htmlH6                  Normal
hi link htmlTitle               Normal

call matchadd('htmlTagID', '\<\(class\|id\)\>\ze=')
