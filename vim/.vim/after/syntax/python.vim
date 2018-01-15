syntax region   pythonFunctionCall start='(' end=')' display contains=ALL
syntax match    pythonKeywordArg /\i*\ze=[^=]/ contained

hi link pythonKeywordArg    Type
