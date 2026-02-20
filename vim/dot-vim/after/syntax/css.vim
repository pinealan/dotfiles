syn match cssAtKeyword /@\(layer\)/
syn region cssAtRule start=/@layer\>/ end=/\ze[{;]/ skipwhite skipnl matchgroup=cssAtKeyword contains=cssAtKeyword,cssVendor,cssComment nextgroup=cssDefinition

hi link cssIdentifier   Identifier
hi link cssAtRule       Special
