" Ordering is important 40
syntax keyword  pythonBoolean False True None
syntax region   pythonDocString start='\'\'\'' end='\'\'\'' display
syntax match    pythonFunction /\w\+\ze(/
syntax region   pythonFunctionCall start='(' end=')' display contains=ALL
syntax match    pythonKeywordArg /\i*\ze=[^=]/ contained

hi link pythonBoolean       Boolean
hi link pythonKeywordArg    Type
hi link pythonDocString     Comment
