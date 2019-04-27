if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim


syn keyword pytestDebug         DEBUG
syn keyword pytestInfo          INFO
syn keyword pytestWarning       WARNING
syn keyword pytestError         ERROR CRITICAL

syn keyword pythonBoolean       False None True
syn match   pythonNumber        "\<0[oO]\=\o\+[Ll]\=\>"
syn match   pythonNumber        "\<0[xX]\x\+[Ll]\=\>"
syn match   pythonNumber        "\<0[bB][01]\+[Ll]\=\>"
syn match   pythonNumber        "\<\%([1-9]\d*\|0\)[Ll]\=\>"
syn match   pythonNumber        "\<\d\+[jJ]\>"
syn match   pythonNumber        "\<\d\+[eE][+-]\=\d\+[jJ]\=\>"
syn match   pythonNumber        "\<\d\+[eE][+-]\=\d\+[jJ]\=\>"
syn match   pythonFloat
      \ "\<\d\+\.\%([eE][+-]\=\d\+\)\=[jJ]\=\%(\W\|$\)\@="
syn match   pythonFloat
      \ "\%(^\|\W\)\zs\d*\.\d\+\%([eE][+-]\=\d\+\)\=[jJ]\=\>"
syn match   pythonFunction "\w\+\ze(.*)"
syn region  pythonString
      \ start=+[buU]\=\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"


hi def link pythonNumber            Number
hi def link pythonFloat             Float
hi def link pythonBoolean           Boolean
hi def link pythonString            String
hi def link pythonFunction          Function

hi def link pytestDebug             Debug
hi def link pytestInfo              Comment
hi def link pytestWarning           Type
hi def link pytestError             Error


let b:current_syntax = "plog"

let &cpo = s:cpo_save
unlet s:cpo_save
