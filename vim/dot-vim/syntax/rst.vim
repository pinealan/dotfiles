" Vim syntax file
" Modified from rst.vim that came with standard distribution
"
" Language: reStructuredText documentation format
" Maintainer: Alan Chan <achan961117@gmail.com>
" Previous Maintainer: Marshall Ward <marshall.ward@gmail.com>
" Website: https://github.com/pinealan/dotfiles
" Latest Revision: 2018-11-18

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim
syn case ignore

" Delimiters
syn keyword     rstTodo             contained FIXME TODO XXX NOTE
syn match rstDelimiter /`/ contained
syn match rstDelimiter /:/ contained
syn match rstAngle /</ contained
syn match rstAngle />/ contained
syn match rstSquare /\[/ contained
syn match rstSquare /\]/ contained

" Sections
syn region rstComment start=/^\s*\.\.\s*.*/ end=/^\s\@!/ contains=rstTodo
syn region rstLabel start=/^\s*\.\.\s*_.*:/ end=/^\s\@!/
syn match rstTransition  /^[=`:.'"~^_*+#-]\{4,}\s*$/
syn match   rstSections "\v^%(([=`:.'"~^_*+#-])\1+\n)?\zs.{1,2}\ze\n([=`:.'"~^_*+#-])\2+$"
    \ contains=@Spell
syn match   rstSections "\v^%(([=`:.'"~^_*+#-])\1{2,}\n)?\zs.{3,}\ze\n([=`:.'"~^_*+#-])\2{2,}$"
    \ contains=@Spell

" Roles, Directives, Fields
syn match rstField /^\s*:[^:]\+:`\@!/ contains=rstDelimiter
syn match rstDirectiveName /::\zs\s\+.*/ contains=rstDelimiter
syn region rstDirective start=/^\s*\.\.\s*.*\ze::/ end=/^\s\@!/ contains=rstField,rstDirectiveName

syn match rstRole /\v(:[^:`]+)?:[^:`]+:`[[:alnum:]~\.\/_<> \s]+`/ contains=rstRoleName,rstRoleTarget
syn match rstRoleName /\v(:[^:`]+)?:[^:`]+:/ contained contains=rstDelimiter
syn match rstRoleTarget /`\v[[:alnum:]~\.\/_<> \s]+`/ contained contains=rstDelimiter

syn match rstEmphasis /\*[^\*]*\*/
syn match rstStrongEmphasis /\*\*[^\(\*\*\)]*\*\*/
syn match rstInlinelink /<.*>/ contains=rstAngle
syn match rstInlineLink /\[.*\]/ contains=rstSquare
syn match rstInlineCode /``[[:alnum:]=\(\)\[\]{}\_s \.,:#\$\\_]\+``/
syn region rstExternalLink start=/[:`]\@<!``\@!/ end=/`\@<=_/ contains=rstDelimiter,rstInlineLink

" Tables
syn region  rstTable                transparent start='^\n\s*+[-=+]\+' end='^$'
      \ contains=rstTableLines
syn match   rstTableLines           contained display '|\|+\%(=\+\|-\+\)\='
syn region  rstSimpleTable          transparent
      \ start='^\n\%(\s*\)\@>\%(\%(=\+\)\@>\%(\s\+\)\@>\)\%(\%(\%(=\+\)\@>\%(\s*\)\@>\)\+\)\@>$'
      \ end='^$'
      \ contains=rstSimpleTableLines
syn match   rstSimpleTableLines     contained display
      \ '^\%(\s*\)\@>\%(\%(=\+\)\@>\%(\s\+\)\@>\)\%(\%(\%(=\+\)\@>\%(\s*\)\@>\)\+\)\@>$'
syn match   rstSimpleTableLines     contained display
      \ '^\%(\s*\)\@>\%(\%(-\+\)\@>\%(\s\+\)\@>\)\%(\%(\%(-\+\)\@>\%(\s*\)\@>\)\+\)\@>$'

" Code literals
syn region  rstLiteralBlock         matchgroup=rstDelimiter
      \ start='::\_s*\n\ze\z(\s\+\)' skip='^$' end='^\z1\@!'
      \ contains=@NoSpell
syn region  rstQuotedLiteralBlock   matchgroup=rstDelimiter
      \ start="::\_s*\n\ze\z([!\"#$%&'()*+,-./:;<=>?@[\]^_`{|}~]\)"
      \ end='^\z1\@!' contains=@NoSpell
syn region rstCodeBlock
      \ start='\.\. \(sourcecode\|code\(-block\)\?\)::\s\+.*\_s*\n\z(\s\+\)'
      \ skip='^$'
      \ end='^\z1\@!'
      \ contains=@NoSpell,rstDirective,rstDirectiveName

" Prepare available languages for inline syntax higlight
if !exists('g:rst_syntax_code_list')
    " A mapping from a Vim filetype to a list of alias patterns (pattern
    " branches to be specific, see ':help /pattern')
    let g:rst_syntax_code_list = {
        \ 'vim': ['vim'],
        \ 'java': ['java'],
        \ 'cpp': ['cpp', 'c++'],
        \ 'lisp': ['lisp'],
        \ 'php': ['php'],
        \ 'python': ['python'],
        \ 'perl': ['perl'],
        \ 'sh': ['sh', 'bash'],
        \ }
elseif type(g:rst_syntax_code_list) == type([])
    " backward compatibility with former list format
    let s:old_spec = g:rst_syntax_code_list
    let g:rst_syntax_code_list = {}
    for s:elem in s:old_spec
        let g:rst_syntax_code_list[s:elem] = [s:elem]
    endfor
endif

" Setup language specific highlights for Code blocks
for s:filetype in keys(g:rst_syntax_code_list)
    unlet! b:current_syntax
    " guard against setting 'isk' option which might cause problems (issue #108)
    let prior_isk = &l:iskeyword
    let s:alias_pattern = ''
                \.'\%('
                \.join(g:rst_syntax_code_list[s:filetype], '\|')
                \.'\)'

    exe 'syn include @rst'.s:filetype.' syntax/'.s:filetype.'.vim'
    exe 'syn region rstDirective'.s:filetype
                \.' matchgroup=rstDirective fold'
                \.' start=#\.\. \(sourcecode\|code\(-block\)\?\)::\s\+'.s:alias_pattern.'\_s*\n\z(\s\+\)#'
                \.' skip=#^$#'
                \.' end=#^\z1\@!#'
                \.' contains=rstDirective,rstDirectiveName,@NoSpell,@rst'.s:filetype

    " reset 'isk' setting, if it has been changed
    if &l:iskeyword !=# prior_isk
        let &l:iskeyword = prior_isk
    endif
    unlet! prior_isk
endfor

" Enable top level spell checking
syntax spell toplevel

hi def link rstTodo                         Todo
hi def link rstComment                      Comment
hi def link rstSections                     Title
hi def link rstDelimiter                    Delimiter
hi def link rstTransition                   Special
hi def link rstAngle                        rstDelimiter
hi def link rstSquare                       rstDelimiter
hi def link rstDelimiter                    Delimiter
hi def link rstLabel                        Statement
hi def link rstDirective                    Statement
hi def link rstDirectiveName                Identifier
hi def link rstField                        Constant
hi def link rstRoleName                     Function
hi def link rstRoleTarget                   Identifier
hi def link rstInlineLink                   Constant
hi def link rstInlineCode                   Constant
hi def link rstExternalLink                 Identifier

hi def link rstLiteralBlock                 String
hi def link rstQuotedLiteralBlock           String
hi def link rstCodeBlock                    String

hi def link rstTableLines                   rstDelimiter
hi def link rstSimpleTableLines             rstTableLines
if exists('g:rst_use_emphasis_colors')
    " TODO: Less arbitrary color selection
    hi def rstEmphasis          ctermfg=13 term=italic cterm=italic gui=italic
    hi def rstStrongEmphasis    ctermfg=1 term=bold cterm=bold gui=bold
else
    hi def rstEmphasis          term=italic cterm=italic gui=italic
    hi def rstStrongEmphasis    term=bold cterm=bold gui=bold
endif

let b:current_syntax = "rst"

let &cpo = s:cpo_save
unlet s:cpo_save
