" Vim filetype plugin
" Language:         Markdown
" Maintainer:       Alan Chan
" Last Change:      2017 Sep 23

if exists("b:did_ftplugin")
    finish
endif

let b:did_ftplugin = 1

setlocal comments=fb:*,fb:0,fb:+,n:> commentstring=>\ %s
setlocal formatoptions+=tcqln formatoptions-=r formatoptions-=o
setlocal formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^[-*+]\\s\\+

setlocal textwidth=80

if exists('b:undo_ftplugin')
    let b:undo_ftplugin .= "|setl cms< com< fo< flp<"
else
    let b:undo_ftplugin = "setl cms< com< fo< flp<"
endif
