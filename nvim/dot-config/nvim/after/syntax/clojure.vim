" Treesitter groups
highlight! link @tag                            Identifier
highlight! link @_include                       clojureMacro
highlight! link @function.macro                 clojureMacro
highlight! link @keyword.function               clojureMacro
highlight! link @keyword.conditional            clojureMacro
highlight! link @keyword.repeat                 clojureMacro
highlight! link @keyword.import                 clojureMacro
highlight! link @keyword.coroutine              clojureMacro

" LSP Semantic highlight groups
highlight! link @lsp.mod.definition.clojure     NONE
highlight! link @lsp.type.function.clojure      NONE
highlight! link @lsp.type.variable.clojure      NONE
highlight! link @lsp.type.macro.clojure         clojureMacro
