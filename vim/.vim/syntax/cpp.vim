" Vim syntax file
" Language:         C++
" Owner:            Alan Chan
" Last Change:      2017 Sept 15

" Base on vim's default cpp.vim by vim-jp, combined with semantics matching from
" https://github.com/octol/vim-cpp-enhanced-highlight by octol
"

if exists("b:current_syntax")
  finish
endif

" Read the C syntax to start with
runtime! syntax/c.vim
unlet b:current_syntax

let s:cpo_save = &cpo
set cpo&vim

syn keyword cppStatement        new delete this friend using
syn keyword cppModifier         inline virtual explicit export
syn keyword cppType             bool wchar_t
syn keyword cppExceptions       throw try catch
syn keyword cppOperator         operator typeid
syn keyword cppOperator         and bitor or xor compl bitand and_eq or_eq xor_eq not not_eq
syn keyword cppStorageClass     mutable
syn keyword cppBoolean          true false
syn keyword cppConstant         __cplusplus
syn match cppCast               "\<\(const\|static\|dynamic\|reinterpret\)_cast\s*<"
syn match cppCast               "\<\(const\|static\|dynamic\|reinterpret\)_cast\s*$"
syn match cppBracket            "<"
syn match cppBracket            ">"
syn match cppScope              "::"

" Match functions
syn match cppFunc               "\w\+\s*(\@="

" Class name declaration
syn match cppStructure          "\<class\>"
syn match cppStructure          "\<namespace\>"
syn match cppStructure          "\<template\>"
syn match cppStructure          "\<typename\>"
syn match cppAccess             "\<private\>"
syn match cppAccess             "\<public\>"
syn match cppAccess             "\<protected\>"

syn match cppClassName          "[0-9A-Za-z:_<>*&]\+\ze\s\+\w\+" contains=cppBracket,cppScope
syn match cppClassName          "\<class\_s\+\w\+\>" contains=cppStructure
syn match cppClassName          "\<namespace\_s\+\w\+\>" contains=cppStructure
syn match cppClassName          "\<template\_s\+\w\+\>" contains=cppStructure
syn match cppClassName          "\<typename\_s\+\w\+\>" contains=cppStructure
syn match cppClassName          "\<private\_s\+\w\+\>" contains=cppAccess
syn match cppClassName          "\<public\_s\+\w\+\>" contains=cppAccess
syn match cppClassName          "\<protected\_s\+\w\+\>" contains=cppAccess

syn match   cppTemplate         "<[0-9A-Za-z:_ <>*&]\+>" contains=cppScope,cppBracket
syn match   cppTemplateFunc     "[0-9A-Za-z_]\+\ze\s*<[0-9A-Za-z_:<>*]\+\s*(" contains=cppTemplate

" C++ 11 extensions
if !exists("cpp_no_cpp11")
  syn keyword cppModifier       override final
  syn keyword cppType           nullptr_t
  syn keyword cppExceptions     noexcept
  syn keyword cppStorageClass   constexpr decltype thread_local
  syn keyword cppConstant       nullptr
  syn keyword cppConstant       ATOMIC_FLAG_INIT ATOMIC_VAR_INIT
  syn keyword cppConstant       ATOMIC_BOOL_LOCK_FREE ATOMIC_CHAR_LOCK_FREE
  syn keyword cppConstant       ATOMIC_CHAR16_T_LOCK_FREE ATOMIC_CHAR32_T_LOCK_FREE
  syn keyword cppConstant       ATOMIC_WCHAR_T_LOCK_FREE ATOMIC_SHORT_LOCK_FREE
  syn keyword cppConstant       ATOMIC_INT_LOCK_FREE ATOMIC_LONG_LOCK_FREE
  syn keyword cppConstant       ATOMIC_LLONG_LOCK_FREE ATOMIC_POINTER_LOCK_FREE
  syn region cppRawString       matchgroup=cppRawStringDelimiter start=+\%(u8\|[uLU]\)\=R"\z([[:alnum:]_{}[\]#<>%:;.?*\+\-/\^&|~!=,"']\{,16}\)(+ end=+)\z1"+ contains=@Spell
endif

" C++ 14 extensions
if !exists("cpp_no_cpp14")
  syn match cppNumber           display "\<0b[01]\+\(u\=l\{0,2}\|ll\=u\)\>"
endif

" The minimum and maximum operators in GNU C++
syn match cppMinMax "[<>]?"

hi link cppAccess               cppStatement
hi link cppModifier             cppStorageClass
hi link cppClassName            cppType
hi link cppTemplate             cppType

hi link cppFunc                 Function
hi link cppCast                 Function
hi link cppTemplateFunc         Function

hi link cppExceptions           Exception
hi link cppOperator             Operator
hi link cppStatement            Statement
hi link cppType                 Type
hi link cppStorageClass         StorageClass
hi link cppStructure            Structure
hi link cppBoolean              Boolean
hi link cppConstant             Constant
hi link cppRawStringDelimiter   Delimiter
hi link cppRawString            String

let b:current_syntax = "cpp"

let &cpo = s:cpo_save
unlet s:cpo_save
