syntax region   pythonFunctionCall start='(' end=')' display contains=
            \ pythonStatement,
            \ pythonFunction,
            \ pythonString,
            \ pythonRawString,
            \ pythonEscape,
            \ pythonNumber,
            \ pythonBuiltin,
            \ pythonExceptions,
            \ pythonKeywordArg
syntax match    pythonKeywordArg /\i*\ze=\(=\)\@!/ display contained

hi link pythonKeywordArg    Type
