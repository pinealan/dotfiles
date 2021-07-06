syntax match clojureNSSlash "\w\@1<=/\ze\w" contained containedin=clojureKeyword,clojureSymbol
syntax match clojureKeyword "\v<:{1,2}%([^ \n\r\t()\[\]{}";@^`~\\/]+/)*[^ \n\r\t()\[\]{}";@^`~\\/]+:@<!>"

syntax match clojureFunc    "(\@1<=[a-zA-Z0-9!#$%&*_+=|'<.>/?-]\+" contains=ALLBUT,@clojureRegexpCharPropertyClasses,@clojureRegexpCharClasses,clojureRegexpMod,clojureRegexpQuantifier,clojureSymbol

syntax keyword clojureDefine deftest testing
syntax keyword clojureSymbol is are
syntax keyword clojureException try+ throw+

highlight default link clojureNSSlash                   Delimiter
