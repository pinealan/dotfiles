syn match cssAtKeyword /@\(layer\)/
syn region cssAtRule start=/@layer\>/   end=/\ze;/ contains=cssStringQ,cssStringQQ,cssUnicodeEscape,cssComment,cssAtKeyword

hi link cssIdentifier   Identifier
