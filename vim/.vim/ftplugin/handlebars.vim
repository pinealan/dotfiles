" Language:     handlebars
" Maintainer:   Alan Chan
" Last Change:  2018 Feb 07

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
    finish
endif

" Behaves just like html
runtime! ftplugin/html.vim
