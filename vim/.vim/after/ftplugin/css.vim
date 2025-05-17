setl ts=2
setl sw=2
setl sts=2
setl commentstring=/*%s*/

setl foldtext=MyFoldText()
function MyFoldText()
  let line = getline(v:foldstart)
  let sub = substitute(substitute(line, '\*\|/\|{{{\d\=', '', 'g'), '^\s*\|\s*$', '', 'g')
  return v:folddashes .. ' ' .. (v:foldend - v:foldstart).. ' lines: ' .. sub
endfunction
