" Vim Color File
"
" Name:       one-dark.vim
" Maintainer: Alan Chan
" License:    The MIT License (MIT)
" Based On:   https://github.com/joshdick/onedark.vim/
" Based On:   https://github.com/MaxSt/FlatColor/

" [ Initialization ] {{{
"
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name="my-onedark"

" [ Color Variables ] {{{
"
let colors = {
    \ "red":            { "x24": "#be5046", "x8": "160" },
    \ "pink":           { "x24": "#e06c75", "x8": "204" },
    \ "green":          { "x24": "#78a339", "x8": "70" },
    \ "teagreen":       { "x24": "#98c379", "x8": "114" },
    \ "teal":           { "x24": "#56b6c2", "x8": "30" },
    \ "yellow":         { "x24": "#e5c07b", "x8": "220" },
    \ "gold":           { "x24": "#d7af5f", "x8": "179" },
    \ "carrot":         { "x24": "#d7875f", "x8": "173" },
    \ "blue":           { "x24": "#61afef", "x8": "75" },
    \ "purple":         { "x24": "#c678dd", "x8": "170" },
    \ "transparent":    { "x24": "NONE",    "x8": "NONE" },
    \ "black":          { "x24": "#000000", "x8": "232" },
    \
    \ "content0":       { "x24": "#dfdfdf", "x8": "253" },
    \ "content1":       { "x24": "#a9a9a9", "x8": "246" },
    \ "content2":       { "x24": "#828282", "x8": "241" },
    \ "content_inv":    { "x24": "#555555", "x8": "237" },
    \
    \ "background_2":   { "x24": "#444444", "x8": "237" },
    \ "background_1":   { "x24": "#383838", "x8": "237" },
    \ "background0":    { "x24": "#28292c", "x8": "235" },
    \ "background1":    { "x24": "#222222", "x8": "234" },
    \ }

let colors["background2"] = colors["black"]
let colors["macro"] = colors["carrot"]
let colors["numeric"] = colors["carrot"]
let colors["statement"] = colors["purple"]
let colors["symbol"] = colors["pink"]

call onecolor#set_all(colors)

" Must appear at the end of the file to work around this oddity:
" https://groups.google.com/forum/#!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
set background=dark
