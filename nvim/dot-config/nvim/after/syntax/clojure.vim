" Treesitter groups
highlight! link @function.macro.clojure         clojureMacro

highlight! link @keyword.function.clojure       clojureDefine
highlight! link @keyword.import.clojure         clojureDefine
highlight! link @keyword.conditional.clojure    clojureMacro
highlight! link @keyword.repeat.clojure         clojureMacro
highlight! link @keyword.coroutine.clojure      clojureMacro

highlight! link @comment.discard.clojure        clojureDiscard

highlight! link @variable.builtin.clojure       Identifier
highlight! link @variable.convention.clojure    Identifier
highlight! link @variable.special.clojure       clojureSpecial
highlight! link @variable.discard.clojure       clojureDiscard

highlight! link @tag.hiccup                     Identifier
highlight! link @tag.attr.hiccup                Type


" LSP Semantic highlight groups
highlight! link @lsp.mod.definition.clojure     NONE
highlight! link @lsp.type.function.clojure      NONE
highlight! link @lsp.type.variable.clojure      NONE
highlight! link @lsp.type.type.clojure          NONE
highlight! link @lsp.type.event.clojure         NONE
highlight! link @lsp.type.macro.clojure         clojureMacro
