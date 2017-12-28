" [onedark.vim](https://github.com/joshdick/onedark.vim/)

let s:overrides = get(g:, "onedark_color_overrides", {})

let s:colors = {
      \ "red":              get(s:overrides, "red",             { "gui": "#E06C75", "cterm": "204", "cterm16": "1" }),
      \ "dark_red":         get(s:overrides, "dark_red",        { "gui": "#BE5046", "cterm": "196", "cterm16": "9" }),
      \ "green":            get(s:overrides, "green",           { "gui": "#98C379", "cterm": "114", "cterm16": "2" }),
      \ "yellow":           get(s:overrides, "yellow",          { "gui": "#E5C07B", "cterm": "214", "cterm16": "11" }),
      \ "dark_yellow":      get(s:overrides, "dark_yellow",     { "gui": "#D19A66", "cterm": "173", "cterm16": "3" }),
      \ "blue":             get(s:overrides, "blue",            { "gui": "#61AFEF", "cterm": "75", "cterm16": "4" }),
      \ "purple":           get(s:overrides, "purple",          { "gui": "#C678DD", "cterm": "170", "cterm16": "5" }),
      \ "cyan":             get(s:overrides, "cyan",            { "gui": "#56B6C2", "cterm": "49", "cterm16": "6" }),
      \
      \ "transparent":      get(s:overrides, "transparent",     { "gui": "NONE",    "cterm": "NONE", "cterm16": "0" }),
      \ "black":            get(s:overrides, "black",           { "gui": "#282C34", "cterm": "233", "cterm16": "0" }),
      \ "dimgrey":          get(s:overrides, "dimgrey",         { "gui": "#283C34", "cterm": "234", "cterm16": "8" }),
      \ "grey":             get(s:overrides, "grey",            { "gui": "#282C34", "cterm": "235", "cterm16": "8" }),
      \ "cursor_grey":      get(s:overrides, "cursor_grey",     { "gui": "#2C323C", "cterm": "236", "cterm16": "8" }),
      \ "visual_grey":      get(s:overrides, "visual_grey",     { "gui": "#3E4452", "cterm": "237", "cterm16": "15" }),
      \ "menu_grey":        get(s:overrides, "menu_grey",       { "gui": "#3E4452", "cterm": "237", "cterm16": "8" }),
      \ "special_grey":     get(s:overrides, "special_grey",    { "gui": "#3B4048", "cterm": "238", "cterm16": "15" }),
      \ "comment_grey":     get(s:overrides, "comment_grey",    { "gui": "#5C6370", "cterm": "241", "cterm16": "15" }),
      \ "vertsplit":        get(s:overrides, "vertsplit",       { "gui": "#181A1F", "cterm": "241", "cterm16": "15" }),
      \ "silver":           get(s:overrides, "silver",          { "gui": "#ABB2BF", "cterm": "246", "cterm16": "7" }),
      \ "white":            get(s:overrides, "white",           { "gui": "#BBC2CF", "cterm": "251", "cterm16": "15" }),
      \
      \ "x245":             get(s:overrides, "x245",            { "gui": "#FFFFFF", "cterm": "245", "cterm16": "7" }),
      \ "x246":             get(s:overrides, "x246",            { "gui": "#666666", "cterm": "245", "cterm16": "7" }),
      \ "x247":             get(s:overrides, "x247",            { "gui": "#777777", "cterm": "247", "cterm16": "7" }),
      \ "x248":             get(s:overrides, "x248",            { "gui": "#888888", "cterm": "248", "cterm16": "15" }),
      \ "x249":             get(s:overrides, "x249",            { "gui": "#999999", "cterm": "249", "cterm16": "15" }),
      \ "x250":             get(s:overrides, "x250",            { "gui": "#AAAAAA", "cterm": "250", "cterm16": "15" }),
      \ "x251":             get(s:overrides, "x251",            { "gui": "#BBBBBB", "cterm": "251", "cterm16": "15" }),
      \ "x252":             get(s:overrides, "x252",            { "gui": "#CCCCCC", "cterm": "252", "cterm16": "15" }),
      \ "x253":             get(s:overrides, "x253",            { "gui": "#DDDDDD", "cterm": "253", "cterm16": "15" }),
      \ "x254":             get(s:overrides, "x254",            { "gui": "#EEEEEE", "cterm": "254", "cterm16": "15" }),
      \ "x255":             get(s:overrides, "x255",            { "gui": "#FFFFFF", "cterm": "255", "cterm16": "15" }),
    \
    \ "bluebg": get(s:overrides, "bluebg", { "gui": "#0000FF", "cterm": "17", "cterm16": "4" }),
      \}

function! onedark#GetColors()
  return s:colors
endfunction
