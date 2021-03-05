syntax match clojureNSSlash "\w\zs/\ze\w" contained containedin=clojureKeyword,clojureSymbol

highlight default link clojureNSSlash                   Delimiter
