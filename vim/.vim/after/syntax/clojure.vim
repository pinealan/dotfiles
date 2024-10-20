syntax match clojureNSSlash "[a-zA-Z0-9!#$%&*_+=|'<.>/?-]\@1<=/\ze[a-zA-Z0-9!#$%&*_+=|'<.>/?-]" contained containedin=clojureKeyword,clojureSymbol
syntax match clojureKeyword "\v<:{1,2}%([^ \n\r\t()\[\]{}";@^`~\\/]+/)*[^ \n\r\t()\[\]{}";@^`~\\/]+:@<!>"
syntax match clojureVariable "&[:a-zA-Z0-9!#$%&*_+='|<.>/?-]\+"

syntax match clojureFunc    "(\@1<=[a-zA-Z0-9!$&*_+=|<.>?-][:a-zA-Z0-9!#$%&*_+='|<.>/?-]*" contains=ALLBUT,@clojureRegexpCharPropertyClasses,@clojureRegexpCharClasses,clojureRegexpMod,clojureRegexpQuantifier,clojureSymbol,clojureAnonArg,clojureRegexpBoundary,clojureRegexpBoundary,clojureQuote

syntax keyword clojureDefine deftest testing
syntax keyword clojureSymbol is are
syntax keyword clojureException try+ throw+

syntax keyword clojureDefine defmemo deflru defttl def-mirror-updater

highlight default link clojureNSSlash                   Delimiter
