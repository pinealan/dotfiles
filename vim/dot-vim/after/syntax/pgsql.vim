syntax case ignore

" The naming is hacky because vim-polygot pgsql was bad at making an extensible highlighting scheme

syntax keyword sqlIdentifier    primary key unique constraint check contained
syntax keyword sqlType          table
syntax keyword sqlConstant      view

hi link sqlIsFunction   Function
