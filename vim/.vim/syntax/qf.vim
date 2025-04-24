if exists('b:current_syntax')
    finish
endif

syn match qfFileName /^[^|]*/ nextgroup=qfSeparatorLeft
syn match qfSeparatorLeft /|/ contained nextgroup=qfLineNr
syn match qfLineNr /[^|]*/ contained nextgroup=qfSeparatorRight contains=qfError,qfWarning,qfInfo,qfNote
syn match qfSeparatorRight '|' contained

syn match qfError / \(E\|error\)/
syn match qfWarning / \(W\|warning\)/
syn match qfInfo / \(I\|info\)/
syn match qfNote / [NH]/

hi def link qfFileName Directory
hi def link qfSeparatorLeft Delimiter
hi def link qfSeparatorRight Delimiter
hi def link qfLineNr LineNr
hi def link qfError DiagnosticError
hi def link qfWarning DiagnosticWarn
hi def link qfInfo DiagnosticInfo
hi def link qfNote DiagnosticHint

let b:current_syntax = 'qf'
