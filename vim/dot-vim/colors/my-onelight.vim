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

let g:colors_name="my-onelight"

" [ Color Variables ] {{{
"
let colors = {
    \ "red":            { "x24": "#e45649", "x8": "166" },
    \ "pink":           { "x24": "#ca1243", "x8": "160" },
    \ "green":          { "x24": "#50a14f", "x8": "71" },
    \ "teagreen":       { "x24": "#327002", "x8": "28" },
    \ "teal":           { "x24": "#067682", "x8": "23" },
    \ "yellow":         { "x24": "#d59201", "x8": "94" },
    \ "gold":           { "x24": "#986801", "x8": "136" },
    \ "carrot":         { "x24": "#eb814c", "x8": "173" },
    \ "blue":           { "x24": "#046dc2", "x8": "33" },
    \ "purple":         { "x24": "#981996", "x8": "127" },
    \ "transparent":    { "x24": "NONE",    "x8": "NONE" },
    \ "black":          { "x24": "#000000", "x8": "232" },
    \
    \ "content0":       { "x24": "#292929", "x8": "16" },
    \ "content1":       { "x24": "#606370", "x8": "60" },
    \ "content2":       { "x24": "#999999", "x8": "145" },
    \ "content_inv":    { "x24": "#c2c2c3", "x8": "250" },
    \
    \ "background_2":   { "x24": "#cccccc", "x8": "251" },
    \ "background_1":   { "x24": "#bbbbbb", "x8": "254" },
    \ "background0":    { "x24": "#fafafa", "x8": "255" },
    \ "background1":    { "x24": "#dddddd", "x8": "251" },
    \ "background2":    { "x24": "#bbbbbb", "x8": "254" },
    \ }

let colors["macro"] = colors["carrot"]
let colors["numeric"] = colors["carrot"]
let colors["statement"] = colors["purple"]
let colors["symbol"] = colors["pink"]
" }}}

call onecolor#set_all(colors)

" Must appear at the end of the file to work around this oddity:
" https://groups.google.com/forum/#!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
set background=light
