require('which-key').add({

    { '<localleader>\'', desc = 'Iced connect' },
    { '<localleader>d', desc = 'Iced document open' },
    { '<localleader>q', desc = 'Iced document close' },
    { '<localleader>l', desc = 'Iced print last' },
    { '<localleader>m', desc = 'Run :lmake' },
    { '<localleader><Tab>', desc = 'Goto corresponding src/test file' },

    { '<localleader>a', desc = 'Sexp insert at tail' },
    { '<localleader>c', desc = 'Sexp convolute' },
    { '<localleader>i', desc = 'Sexp insert at head' },
    { '<localleader>o', desc = 'Sexp raise element' },
    { '<localleader>D', desc = 'Sexp duplicate' },
    { '<localleader>O', desc = 'Sexp raise list' },
    { '<localleader>p', desc = 'Sexp splice' },

    -- Iced: evaluate
    { '<localleader>e', group = 'iced eval' },
    { '<localleader>ee', desc = 'Eval top list' },
    { '<localleader>ef', desc = 'Eval list' },
    { '<localleader>ew', desc = 'Eval element' },
    { '<localleader>eE', desc = 'Eval & print top list' },
    { '<localleader>eF', desc = 'Eval & print list' },
    { '<localleader>eW', desc = 'Eval & print element' },

    -- Iced: buffer
    { '<localleader>b', group = 'iced buffer' },
    { '<localleader>bd', desc = 'Browse dependencies' },
    { '<localleader>br', desc = 'Browse references' },
    { '<localleader>be', desc = 'Print last error' },
    { '<localleader>bl', desc = 'Print last result' },

    -- Iced: refactor
    { '<localleader>b', group = 'iced refactor' },
    { '<localleader>ra', desc = 'Add arity' },
    { '<localleader>rc', desc = 'Clean ns form' },
    { '<localleader>re', desc = 'Extract to function' },
    { '<localleader>rm', desc = 'Move to let' },
    { '<localleader>rn', desc = 'Add namespace' },
    { '<localleader>rs', desc = 'Rename symbol' },
    { '<localleader>rr', desc = 'Require' },
    { '<localleader>rf', desc = 'Thread first' },
    { '<localleader>rl', desc = 'Thread last' },

    -- Sexp: wrap & insert
    { '<localleader>w', group = 'sexp wrap & insert' },
    { '<localleader>wi', desc = 'Wrap element in parens & insert' },
    { '<localleader>wa', desc = 'Wrap element in parens & append' },
    { '<localleader>w(', desc = 'Wrap element in parens & insert' },
    { '<localleader>w)', desc = 'Wrap element in parens & append' },
    { '<localleader>w[', desc = 'Wrap element in brackets & insert' },
    { '<localleader>w]', desc = 'Wrap element in brackets & append' },
    { '<localleader>w{', desc = 'Wrap element in braces & insert' },
    { '<localleader>w}', desc = 'Wrap element in braces & append' },

    { '<localleader>ww', group = 'sexp list wrap & insert' },
    { '<localleader>wwi', desc = 'Wrap list in parens & insert' },
    { '<localleader>wwa', desc = 'Wrap list in parens & append' },
    { '<localleader>ww(', desc = 'Wrap list in parens & insert' },
    { '<localleader>ww)', desc = 'Wrap list in parens & append' },
    { '<localleader>ww[', desc = 'Wrap list in brackets & insert' },
    { '<localleader>ww]', desc = 'Wrap list in brackets & append' },
    { '<localleader>ww{', desc = 'Wrap list in braces & insert' },
    { '<localleader>ww}', desc = 'Wrap list in braces & append' },

    { '<localleader>W', group = 'sexp wrap' },
    { '<localleader>W(', desc = 'Wrap element in parens' },
    { '<localleader>W[', desc = 'Wrap element in brackets' },
    { '<localleader>W{', desc = 'Wrap element in braces' },

    { '<localleader>W', group = 'sexp list wrap' },
    { '<localleader>WW(', desc = 'Wrap list in parens' },
    { '<localleader>WW[', desc = 'Wrap list in brackets' },
    { '<localleader>WW{', desc = 'Wrap list in braces' },
})
