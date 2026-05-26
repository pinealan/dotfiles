; ===== Explanation
; Adopt from the official nvim-treesitter queries/clojure/highlights.scm.
; Parsers for lisps are a bit weird in that they just return the raw forms.
; This means we have to do a bit of extra work in the queries to get things
; highlighted as they should be.
;
; For the most part this means that some things have to be assigned multiple
; groups.
; By doing this we can add a basic capture and then later refine it with more
; specialized captures.
; This can mean that sometimes things are highlighted weirdly because they
; have multiple highlight groups applied to them.

; ===== Literals

; Higher priority to mark the whole sexpr as a comment, and override LSP
((dis_expr) @comment.discard (#set! priority 135))

(num_lit) @number
(bool_lit) @boolean
(nil_lit) @constant.builtin

(str_lit) @string
(char_lit) @character

((comment) @comment @spell (#set! priority 135))

(regex_lit) @string.regexp
[ "'" "`" ] @string.escape

[ "~" "~@" "#" ] @punctuation.special
[ "{" "}" "[" "]" "(" ")" ] @punctuation.bracket

; ===== Symbols

; General symbol highlighting
; (sym_lit) always has a :name (sym_name), and sometimes a :namespace (sym_ns). When there is no
; namespace, then the whole node is (sym_name) and it will be highlighted entired as that. When
; there is a namespace, there will be a / in between the (sym_ns) and (sym_name), which is the only
; time the @variable.builtin group will get assigned
(sym_lit) @punctuation.delimiter
(sym_ns) @type
(sym_name) @variable

; Keywords have a similar structure as symbols
(kwd_lit) @punctuation.delimiter
(kwd_ns) @type
(kwd_name) @keyword

; My convention of using & prefix for atoms
((sym_name) @variable.convention
  (#lua-match? @variable.convention "^&.+"))

; Quoted symbols
(quoting_lit
  (sym_lit) @string.special.symbol)

(syn_quoting_lit
  (sym_lit) @string.special.symbol)

; Builtin repl variables
((sym_name) @variable.builtin
  (#any-of? @variable.builtin "*1" "*2" "*3" "*e"))

; Builtin dynamic variables
((sym_name) @variable.builtin
  (#any-of? @variable.builtin
    "*agent*" "*allow-unresolved-vars*" "*assert*" "*clojure-version*" "*command-line-args*"
    "*compile-files*" "*compile-path*" "*compiler-options*" "*data-readers*"
    "*default-data-reader-fn*" "*err*" "*file*" "*flush-on-newline*" "*fn-loader*" "*in*"
    "*math-context*" "*ns*" "*out*" "*print-dup*" "*print-length*" "*print-level*" "*print-meta*"
    "*print-namespace-maps*" "*print-readably*" "*read-eval*" "*reader-resolver*" "*source-path*"
    "*suppress-read*" "*unchecked-math*" "*use-context-classloader*" "*verbose-defrecords*"
    "*warn-on-reflection*"))

; Used in destructure pattern
((sym_name) @variable.parameter.builtin
  (#lua-match? @variable.parameter.builtin "^&$"))

; ===== Functions calls

(list_lit
  .
  (sym_lit
    (sym_name) @function.call))

(anon_fn_lit
  .
  (sym_lit
    (sym_name) @function.call))

; Lambda function args (special)
((sym_name) @variable.parameter.builtin
  (#lua-match? @variable.parameter.builtin "^%%%d*$"))

((sym_name) @variable.parameter.builtin
  (#eq? @variable.parameter.builtin "%&"))

; ===== Interop

; Constructor
;((sym_name) @constructor
;  (#lua-match? @constructor "^-%>[^>].*"))

; Symbols with `.` but not `/`
;(sym_lit
;  !namespace
;  name: (sym_name) @_name
;  (#lua-match? @_name "^[^.]+[.]")) @type

; (.instanceMember instance args*)
; (.instanceMember Classname args*)
((sym_name) @function.method
  (#lua-match? @function.method "^%.[^-]"))

; (.-instanceField instance)
((sym_name) @variable.member
  (#lua-match? @variable.member "^%.%-%S*"))

;  Classname/staticField
(sym_lit
  namespace: (sym_ns) @_namespace
  (#lua-match? @_namespace "^[%u]%S*$")) @variable.member

; (Classname/staticMethod args*)
(list_lit
  .
  (sym_lit
    namespace: (sym_ns) @_namespace
    (#lua-match? @_namespace "^%u")) @function.method)

; ===== Stdlib macros

; def variants
((sym_name) @keyword.function
  (#any-of? @keyword.function
    "def" "defonce" "defrecord" "defmacro" "definline" "definterface" "defmulti" "defmethod"
    "defstruct" "defprotocol" "deftype" "declare"))

; Function definitions
(list_lit
  .
  ((sym_lit
    (sym_name) @keyword.function) @keyword.function
    (#any-of? @keyword.function "defn" "defn-" "fn" "fn*"))
  .
  (sym_lit
    (sym_name) @function))

; Special blocks
((sym_name) @comment
  (#eq? @comment "comment")
  (#set! priority 135))

((sym_name) @variable.special
  (#eq? @variable.special "do"))

; unused variables
((sym_name) @variable.special
  (#lua-match? @variable.special "^_.*$"))

; ===== Stdlib control flow macros

; Conditionals
((sym_name) @keyword.conditional
  (#any-of? @keyword.conditional
   "case" "cond" "cond->" "cond->>" "condp" "if" "if-let" "if-not" "if-some" "when"
   "when-first" "when-let" "when-not" "when-some"))

; Repeats
((sym_name) @keyword.repeat
  (#any-of? @keyword.repeat "doseq" "dotimes" "for" "loop" "recur" "while" "->" "->>" "let" "let-fn"))

; Exception
((sym_name) @keyword.exception
  (#any-of? @keyword.exception "throw" "try" "catch" "finally"))

; Namespaces
(list_lit
  .
  (sym_lit) @keyword.import
  (#eq? @keyword.import "ns")
  .
  (sym_lit) @module)

; Includes
(list_lit
  .
  (sym_lit
    (sym_name) @keyword.import
    (#any-of? @keyword.import "import" "require" "use")))

; ===== Others

; core.async
((sym_name) @keyword.coroutine
  (#any-of? @keyword.coroutine
    "alts!" "alts!!" "await" "await-for" "await1" "chan" "close!" "future" "go" "sync" "thread"
    "timeout" "<!" "<!!" ">!" ">!!"))

; Hiccup vectors, set priority to override LSP
(vec_lit
  . (kwd_lit) @tag.hiccup
  . (map_lit
      (kwd_lit
        name: (kwd_name) @tag.attr.hiccup
        (#any-of? @tag.attr.hiccup "class" "href" "type" "placeholder")))?
  (#set! priority 130))
