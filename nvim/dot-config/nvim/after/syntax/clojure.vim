" Treesitter groups
highlight! link @function.macro                 clojureMacro

highlight! link @keyword.function               clojureDefine
highlight! link @keyword.import                 clojureDefine
highlight! link @keyword.conditional            clojureMacro
highlight! link @keyword.repeat                 clojureMacro
highlight! link @keyword.coroutine              clojureMacro

highlight! link @comment.discard                clojureDiscard

highlight! link @variable.builtin               Identifier
highlight! link @variable.convention            Identifier
highlight! link @variable.special               clojureSpecial
highlight! link @variable.discard               clojureDiscard

highlight! link @tag.hiccup                     Identifier
highlight! link @tag.attr.hiccup                Type


" LSP Semantic highlight groups
highlight! link @lsp.mod.definition.clojure     NONE
highlight! link @lsp.type.function.clojure      NONE
highlight! link @lsp.type.variable.clojure      NONE
highlight! link @lsp.type.type.clojure          NONE
highlight! link @lsp.type.event.clojure         NONE
highlight! link @lsp.type.macro.clojure         clojureMacro
