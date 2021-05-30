syntax match clojureNSSlash "\w\zs/\ze\w" contained containedin=clojureKeyword,clojureSymbol
syntax match clojureKeyword "\v<:{1,2}%([^ \n\r\t()\[\]{}";@^`~\\/]+/)*[^ \n\r\t()\[\]{}";@^`~\\/]+:@<!>"

highlight default link clojureNSSlash                   Delimiter
