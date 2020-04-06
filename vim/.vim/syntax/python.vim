" Vim syntax file
" Language:     Python
" Maintainer:   Alan Chan
"
" Highly customized for my own eyes. Python 3 only. Parses and highlights
" language features such as:
" - Argument defaults
" - Keyword arguments
" - Tuple, list, dictionary
" - Built-in constants, functions, exceptions
"
" Also picks up modern python features (up to 3.7), such as:
" - Async
" - F-strings replacement fields
" - Typed python
"

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

" {{{ Primary language features and keywords
" Keep Python keywords in alphabetical order inside groups for easy
" comparison with the table in the 'Python Language Reference'
" https://docs.python.org/3/reference/lexical_analysis.html#keywords.
" Groups are in the order presented in NAMING CONVENTIONS in syntax.txt.
" Exceptions come last at the end of each group (class and def below).
"
syn keyword pythonBoolean       False None True
syn keyword pythonConditional   elif else if
syn keyword pythonRepeat        for while
syn keyword pythonOperator      and in is not or
syn keyword pythonKeyword       as assert break continue del global
syn keyword pythonKeyword       lambda nonlocal pass return with yield
syn keyword pythonException     except finally raise try
syn keyword pythonAsync         async await

syn keyword pythonSelf          self cls

syn keyword pythonStructure     class skipwhite
syn keyword pythonStructure     def nextgroup=pythonFunctionCall skipwhite
syn keyword pythonInclude       from import

syn match   pythonDelimiter     "[,:=\(!=\)]"
syn match   pythonDelimiter     "->" nextgroup=pythonPrimaryT skipwhite

" For copy-pasta, python primary is `\h\k*\(\.\h\k*\)*`
" What is a python primary?
" https://docs.python.org/3/reference/expressions.html?highlight=primary#primaries

syn match   pythonFunctionCall  "\h\k*\ze(" nextgroup=pythonParen skipwhite
syn match   pythonDeclFunction  "\%(def\s\+\)\@<=\h\k*"
syn match   pythonDeclClass     "\s*\%(class\s\+\)\@<=\h\k*"

syn region  pythonDict display matchgroup=pythonPunctuation
    \ start='{' end='}' contains=TOP,pythonTypeHint

syn region  pythonList display matchgroup=pythonPunctuation
    \ start='\[' end='\]' contains=TOP,pythonTypeHint

syn region  pythonParen display matchgroup=pythonPunctuation
    \ start='(' end=')' contains=TOP,pythonPrimaryT,pythonPrimaryD

syn match   pythonKwarg /\i\+ *\ze=[^=]/ contained containedin=pythonParen contains=pythonDelimiter
syn match   pythonKwarg /\i\+\ze: *\i* *=[^=]/ contained containedin=pythonParen contains=pythonDelimiter

" Helper matchers
syn match   pythonPrimaryD      /\v\h\k*(\.\h\k*)*/ contained contains=None
syn match   pythonPrimaryT      /\v\h\k*(\.\h\k*)*/ contained contains=None

syn match   pythonDecorator     "^ *@" nextgroup=pythonPrimaryD skipwhite
syn match   pythonTypeHint      /\v(lambda( +\h\k*(, *\h\k*)*)?)@<!:/
    \ display contains=pythonDelimiter nextgroup=pythonPrimaryT skipwhite

syn match   pythonComment       "#.*$" contains=@Spell,Todo

" }}}

" Strings {{{
" Python 3 'text' -> u'text' are the same
" https://www.python.org/dev/peps/pep-0414/
"
syn region  pythonString
    \ start=+[uU]\=\z(['"]\)+ end=+\z1+ skip="\\\\\|\\\z1"
    \ contains=pythonEscape,pythonFEscape,@Spell

syn region  pythonLongString
    \ start=+[uU]\=\z("""\)+ end=+\z1+ keepend
    \ contains=pythonEscape,pythonSpaceError,pythonDoctest,@Spell,Todo

syn region  pythonRawString
    \ start=+[bBrR]\{1,2}\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"

syn region  pythonRawString
    \ start=+[bBrR]\{1,2}\z('''\|"""\)+ end="\z1"

syn match   pythonEscape        +\\[abfnrtv'"\\]+ contained
syn match   pythonEscape        "\\\o\{1,3}" contained
syn match   pythonEscape        "\\x\x\{2}" contained
syn match   pythonEscape        "\%(\\u\x\{4}\|\\U\x\{8}\)" contained

" Python allows case-insensitive Unicode IDs: http://www.unicode.org/charts/
syn match   pythonEscape        "\\N{\a\+\%(\s\a\+\)*}" contained
syn match   pythonEscape        "\\$" contained
syn match   pythonEscape        /%\(([^\)]*)\)\?[diouxXeEfFgGcrsa]/ contained contains=pythonOldStringField
syn match   pythonOldStringField    /(\zs[^\)]*\ze)/ contained

" f-strings
syn region  pythonFString
    \ start=+[fF]\z(['"]\)+ end=+\z1+ skip=+\\\\\|\\\z1+ keepend
    \ contains=pythonEscape,pythonFEscape,@Spell

syn region  pythonFLongString
    \ start=+[fF]\z('''\|"""\)+ end=+\z1+ keepend
    \ contains=pythonEscape,pythonFEscape,pythonSpaceError,@Spell

syn match   pythonFEscape           /{[^{]\{-}:\?}/ contained contains=pythonFStringField
syn match   pythonFStringField      /{\zs[^{}]*/ contained contains=None
" }}}

" Inline SQL {{{
syn keyword pythonSQLKeyword    ALTER ATTACH DETACH CREATE DROP EXPLAIN ? contained
syn keyword pythonSQLKeyword    SELECT INSERT UPDATE DELETE REPLACE ROLLBACK contained
syn keyword pythonSQLKeyword    PRIMARY UNIQUE FOREIGN REFERENCES VALUES contained
syn keyword pythonSQLKeyword    IF NOT FROM WITH KEY EXISTS INDEXED INTO BY contained
syn keyword pythonSQLType       NULL INT INTEGER REAL TEXT STRING FLOAT BLOB contained
syn keyword pythonSQLType       DATABASE TABLE TRIGGER TRANSACTION INDEX VIEW contained
syn region  pythonSQLstring start="'''" end="'''" keepend contains=pythonSQLKeyword,pythonSQLType
" }}}

" Numbers {{{
" It is very important to understand all details before changing the
" regular expressions below or their order.
" The word boundaries are *not* the floating-point number boundaries
" because of a possible leading or trailing decimal point.
" The expressions below ensure that all valid number literals are
" highlighted, and invalid number literals are not.  For example,
"
" - a decimal point in '4.' at the end of a line is highlighted,
" - a second dot in 1.0.0 is not highlighted,
" - 08 is not highlighted,
" - 08e0 or 08j are highlighted,
"
" and so on, as specified in the 'Python Language Reference'.
" https://docs.python.org/2/reference/lexical_analysis.html#numeric-literals
" https://docs.python.org/3/reference/lexical_analysis.html#numeric-literals
"
syn match   pythonNumber        "\<0[oO]\=\o\+[Ll]\=\>"
syn match   pythonNumber        "\<0[xX]\x\+[Ll]\=\>"
syn match   pythonNumber        "\<0[bB][01]\+[Ll]\=\>"
syn match   pythonNumber        "\<\%([1-9]\d*\|0\)[Ll]\=\>"
syn match   pythonNumber        "\<\d\+[jJ]\>"
syn match   pythonNumber        "\<\d\+[eE][+-]\=\d\+[jJ]\=\>"
syn match   pythonFloat
      \ "\<\d\+\.\%([eE][+-]\=\d\+\)\=[jJ]\=\%(\W\|$\)\@="
syn match   pythonFloat
      \ "\%(^\|\W\)\zs\d*\.\d\+\%([eE][+-]\=\d\+\)\=[jJ]\=\>"
" }}}

" Built-in functions are in alphabetical order. {{{
" http://docs.python.org/3/library/constants.html
" http://docs.python.org/3/library/functions.html
"
syn keyword pythonBuiltin       abs all any bin bool bytearray callable chr
syn keyword pythonBuiltin       classmethod compile complex delattr dict dir
syn keyword pythonBuiltin       divmod enumerate eval filter float format
syn keyword pythonBuiltin       frozenset getattr globals hasattr hash
syn keyword pythonBuiltin       hex input int isinstance
syn keyword pythonBuiltin       issubclass iter len list locals map max
syn keyword pythonBuiltin       memoryview min next object oct open ord pow
syn keyword pythonBuiltin       print property range repr reversed round set
syn keyword pythonBuiltin       setattr slice sorted staticmethod str
syn keyword pythonBuiltin       sum super tuple type vars zip __import__
syn keyword pythonBuiltin       ascii bytes exec
" allow shadowing of these built-ins
"syn keyword pythonBuiltin       help id
" avoid highlighting attributes as builtins
"syn match   pythonAttribute     /\.\h\w*/hs=s+1 contains=ALLBUT,pythonBuiltin,pythonKeywordArg transparent
" }}}

" Builtin exceptions {{{
" From the 'Python Library Reference' class hierarchy at the bottom.
" http://docs.python.org/3/library/exceptions.html

" builtin base exceptions (used mostly as base classes for other exceptions) {{{
syn keyword pythonExceptions    BaseException Exception
syn keyword pythonExceptions    ArithmeticError BufferError
syn keyword pythonExceptions    LookupError

" builtin exceptions (actually raised)
syn keyword pythonExceptions    AssertionError AttributeError
syn keyword pythonExceptions    EOFError FloatingPointError GeneratorExit
syn keyword pythonExceptions    ImportError IndentationError
syn keyword pythonExceptions    IndexError KeyError KeyboardInterrupt
syn keyword pythonExceptions    MemoryError NameError NotImplementedError
syn keyword pythonExceptions    OSError OverflowError ReferenceError
syn keyword pythonExceptions    RuntimeError StopIteration SyntaxError
syn keyword pythonExceptions    SystemError SystemExit TabError TypeError
syn keyword pythonExceptions    UnboundLocalError UnicodeError
syn keyword pythonExceptions    UnicodeDecodeError UnicodeEncodeError
syn keyword pythonExceptions    UnicodeTranslateError ValueError
syn keyword pythonExceptions    ZeroDivisionError

" builtin OS exceptions in Python 3
syn keyword pythonExceptions    BlockingIOError BrokenPipeError
syn keyword pythonExceptions    ChildProcessError ConnectionAbortedError
syn keyword pythonExceptions    ConnectionError ConnectionRefusedError
syn keyword pythonExceptions    ConnectionResetError FileExistsError
syn keyword pythonExceptions    FileNotFoundError InterruptedError
syn keyword pythonExceptions    IsADirectoryError NotADirectoryError
syn keyword pythonExceptions    PermissionError ProcessLookupError
syn keyword pythonExceptions    RecursionError StopAsyncIteration
syn keyword pythonExceptions    TimeoutError
" }}}

" builtin warnings {{{
syn keyword pythonExceptions    BytesWarning DeprecationWarning FutureWarning
syn keyword pythonExceptions    ImportWarning PendingDeprecationWarning
syn keyword pythonExceptions    RuntimeWarning SyntaxWarning UnicodeWarning
syn keyword pythonExceptions    UserWarning Warning ResourceWarning
" }}}
" }}}

" Stdlib typing module (since Python 3.5) {{{
" special typing primitives
syn keyword pythonBuiltinType   Any Callable ClassVar ForwardRef Generic
syn keyword pythonBuiltinType   Optional Text Tuple Type TypeVar Union

" ABCs
syn keyword pythonBuiltinType   AbstractSet ByteString Container ContextManager
syn keyword pythonBuiltinType   Hashable ItemsView Iterable Iterator KeysView
syn keyword pythonBuiltinType   Mapping MappingView MutableMapping
syn keyword pythonBuiltinType   MutableSequence MutableSet Sequence Sized
syn keyword pythonBuiltinType   ValuesView

" protocols
syn keyword pythonBuiltinType   Reversible SupportsAbs SupportsBytes
syn keyword pythonBuiltinType   SupportsComplex SupportsFloat SupportsInt
syn keyword pythonBuiltinType   SupportsRound

" async types
syn keyword pythonBuiltinType   Awaitable AsyncIterator AsyncIterable Coroutine
syn keyword pythonBuiltinType   Collection AsyncGenerator AsyncContextManager

" concrete collection types
syn keyword pythonBuiltinType   ChainMap Counter Deque Dict DefaultDict List
syn keyword pythonBuiltinType   OrderedDict Set FrozenSet NamedTuple Generator

" other types
syn keyword pythonBuiltinType   AnyStr NewType NoReturn
syn keyword pythonBuiltinType   Pattern Match IO TextIO BinaryIO
" }}}

" trailing whitespace
syn match   pythonSpaceError    display excludenl "\s\+$"

" mixed tabs and spaces
syn match   pythonSpaceError    display " \+\t"
syn match   pythonSpaceError    display "\t\+ "


" Sync at the beginning of class, function, or method definition.
syn sync match pythonSync grouphere NONE "^\s*\%(def\|class\)\s\+\h\w*\s*("

syn keyword Todo    TODO NOTE FIXME REFACTOR HARDCODE HACK contained
syn keyword Todo    Todo Note Fixme Refactor Hardcode Hack contained
syn keyword Todo    todo note fixme refactor hardcode contained

" Highlights {{{
hi def link pythonComment           Comment
hi def link pythonNumber            Number
hi def link pythonFloat             Float
hi def link pythonBoolean           Boolean

hi def link pythonConditional       Conditional
hi def link pythonStructure         Structure
hi def link pythonRepeat            Repeat
hi def link pythonOperator          Operator
hi def link pythonKeyword           Keyword
hi def link pythonAsync             Statement

hi def link pythonException         Exception

hi def link pythonInclude           Statement
hi def link pythonDecorator         Constant

hi def link pythonFunctionCall      Function
hi def link pythonDecoratorCall     Function
hi def link pythonDeclFunction      Function

hi def link pythonKwarg             Identifier
hi def link pythonTypeHint          Type
hi def link pythonDeclClass         Type

hi def link pythonPrimaryD          Function
hi def link pythonPrimaryT          Type

hi def link pythonSelf              Special

hi def link pythonString            String
hi def link pythonLongString        String
hi def link pythonFString           String
hi def link pythonFLongString       String

hi def link pythonStringField       Identifier
hi def link pythonOldStringField    pythonStringField
hi def link pythonFStringField      pythonStringField

hi def link pythonRawString         Constant
hi def link pythonSQLString         Constant

hi def link pythonSQLKeyword        Statement
hi def link pythonSQLType           Type

hi def link pythonFEscape           Special
hi def link pythonEscape            Special
hi def link pythonBuiltin           Function
hi def link pythonBuiltinType       Type
hi def link pythonExceptions        pythonBuiltin
hi def link pythonSpaceError        Error

hi def link pythonPunctuation       Special
hi def link pythonDelimiter         Delimiter

" }}}

let b:current_syntax = "python"

let &cpo = s:cpo_save
unlet s:cpo_save
