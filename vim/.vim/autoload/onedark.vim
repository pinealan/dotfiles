let s:overrides = get(g:, "color_overrides", {})

let s:colors = {
      \ "pink":             get(s:overrides, "pink",            { "gui": "#E06C75", "cterm": "204", "cterm16": "1" }),
      \ "red":              get(s:overrides, "red",             { "gui": "#BE5046", "cterm": "160", "cterm16": "9" }),
      \ "green":            get(s:overrides, "green",           { "gui": "#98C379", "cterm": "70",  "cterm16": "2" }),
      \ "teagreen":         get(s:overrides, "teagreen",        { "gui": "#98C379", "cterm": "114", "cterm16": "2" }),
      \ "yellow":           get(s:overrides, "yellow",          { "gui": "#E5C07B", "cterm": "220", "cterm16": "11" }),
      \ "gold":             get(s:overrides, "gold",            { "gui": "#E5C07B", "cterm": "179", "cterm16": "11" }),
      \ "carrot":           get(s:overrides, "carrot",          { "gui": "#D19A66", "cterm": "173", "cterm16": "3" }),
      \ "blue":             get(s:overrides, "blue",            { "gui": "#61AFEF", "cterm": "75", "cterm16": "4" }),
      \ "navy":             get(s:overrides, "navy",            { "gui": "#61AFEF", "cterm": "17", "cterm16": "4" }),
      \ "purple":           get(s:overrides, "purple",          { "gui": "#C678DD", "cterm": "170", "cterm16": "5" }),
      \ "cyan":             get(s:overrides, "cyan",            { "gui": "#56B6C2", "cterm": "44", "cterm16": "6" }),
      \
      \ "transparent":      get(s:overrides, "transparent",     { "gui": "NONE",    "cterm": "NONE", "cterm16": "0" }),
      \ "menu_grey":        get(s:overrides, "menu_grey",       { "gui": "#3E4452", "cterm": "237", "cterm16": "8" }),
      \ "special_grey":     get(s:overrides, "special_grey",    { "gui": "#3B4048", "cterm": "238", "cterm16": "15" }),
      \ "vertsplit":        get(s:overrides, "vertsplit",       { "gui": "#181A1F", "cterm": "241", "cterm16": "15" }),
      \ "silver":           get(s:overrides, "silver",          { "gui": "#ABB2BF", "cterm": "246", "cterm16": "7" }),
      \ "white":            get(s:overrides, "white",           { "gui": "#BBC2CF", "cterm": "251", "cterm16": "15" }),
      \
      \ "x232":             get(s:overrides, "x232",            { "gui": "#000000", "cterm": "232", "cterm16": "0" }),
      \ "x233":             get(s:overrides, "x233",            { "gui": "#0B0B0B", "cterm": "233", "cterm16": "0" }),
      \ "x234":             get(s:overrides, "x234",            { "gui": "#161616", "cterm": "234", "cterm16": "0" }),
      \ "x235":             get(s:overrides, "x235",            { "gui": "#212121", "cterm": "235", "cterm16": "0" }),
      \ "x236":             get(s:overrides, "x236",            { "gui": "#2C2C2C", "cterm": "236", "cterm16": "0" }),
      \ "x237":             get(s:overrides, "x237",            { "gui": "#373737", "cterm": "237", "cterm16": "0" }),
      \ "x238":             get(s:overrides, "x238",            { "gui": "#424242", "cterm": "238", "cterm16": "8" }),
      \ "x239":             get(s:overrides, "x239",            { "gui": "#4D4D4D", "cterm": "239", "cterm16": "8" }),
      \ "x240":             get(s:overrides, "x240",            { "gui": "#5B5B5B", "cterm": "240", "cterm16": "8" }),
      \ "x241":             get(s:overrides, "x241",            { "gui": "#696969", "cterm": "241", "cterm16": "8" }),
      \ "x242":             get(s:overrides, "x242",            { "gui": "#707070", "cterm": "242", "cterm16": "8" }),
      \ "x243":             get(s:overrides, "x243",            { "gui": "#7B7B7B", "cterm": "243", "cterm16": "8" }),
      \ "x244":             get(s:overrides, "x244",            { "gui": "#888888", "cterm": "244", "cterm16": "7" }),
      \ "x245":             get(s:overrides, "x245",            { "gui": "#999999", "cterm": "245", "cterm16": "7" }),
      \ "x246":             get(s:overrides, "x246",            { "gui": "#A7A7A7", "cterm": "245", "cterm16": "7" }),
      \ "x247":             get(s:overrides, "x247",            { "gui": "#B2B2B2", "cterm": "247", "cterm16": "7" }),
      \ "x248":             get(s:overrides, "x248",            { "gui": "#BCBCBC", "cterm": "248", "cterm16": "7" }),
      \ "x249":             get(s:overrides, "x249",            { "gui": "#C8C8C8", "cterm": "249", "cterm16": "7" }),
      \ "x250":             get(s:overrides, "x250",            { "gui": "#CCCCCC", "cterm": "250", "cterm16": "15" }),
      \ "x251":             get(s:overrides, "x251",            { "gui": "#D5D5D5", "cterm": "251", "cterm16": "15" }),
      \ "x252":             get(s:overrides, "x252",            { "gui": "#DBDBDB", "cterm": "252", "cterm16": "15" }),
      \ "x253":             get(s:overrides, "x253",            { "gui": "#E8E8E8", "cterm": "253", "cterm16": "15" }),
      \ "x254":             get(s:overrides, "x254",            { "gui": "#F4F4F4", "cterm": "254", "cterm16": "15" }),
      \ "x255":             get(s:overrides, "x255",            { "gui": "#FFFFFF", "cterm": "255", "cterm16": "15" }),
      \}

function! onedark#GetColors()
  return s:colors
endfunction
