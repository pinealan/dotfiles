syn keyword htmlTagID   class id

hi link htmlTag         Delimiter
hi link htmlEndTag      Delimiter
hi link htmlTagName     Identifier

hi link htmlTagID       Function

call matchadd('htmlTagID', '\<\(class\|id\)\>\ze=')
