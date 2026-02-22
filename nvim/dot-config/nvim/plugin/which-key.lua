--- Which key

require('which-key').setup({
    delay = function(ctx) return ctx.plugin and 0 or 100 end,
    icons = {
        mappings = false,
        keys = {
            Up = "↑",
            Down = "↓",
            Left = "←",
            Right = "→",
            C = "⌃",
            M = "⌥",
            D = "⌘ ",
            S = "⇧",
            Esc = "⎋",
            NL = "⏎",
            BS = "⌫",
            Space = "␣",
            Tab = "⇥",
        }

    },
    plugins = {
        marks = false,
        registers = true,
    }
})
require('which-key').add({
    { '<M-n>', desc = 'Location list next' },
    { '<M-p>', desc = 'Location list prev' },
    { '<C-n>', desc = 'Quickfix list next' },
    { '<C-p>', desc = 'Quickfix list prev' },

    -- g
    { 'gp', desc = 'GitGutter: Preview hunk' },
    { 'gs', desc = 'GitGutter: Stage hunk' },
    { 'gu', desc = 'GitGutter: Undo hunk' },
    { 'g[', desc = 'GitGutter: Prev hunk' },
    { 'g]', desc = 'GitGutter: Next hunk' },
    { 'gx', desc = 'Open file/URL at cursor' },

    -- Leader: control
    { '<leader>c', desc = 'Show highlight group' },
    { '<leader>h', desc = 'Toggle highlight search' },
    { '<leader>p', desc = 'Toggle paste mode' },

    -- Leader: nav
    { '<leader>"', desc = 'Split horizontal' },
    { '<leader>\'', desc = 'Split vertical' },
    { '<leader>d', desc = 'Unload buffer' },
    { '<leader>e', desc = 'Edit file in current directory' },
    { '<leader>q', desc = 'Quit window' },
    { '<leader><Tab>', desc = 'Goto alt buffer' },

    -- Leader: editing
    { '<leader>r', desc = 'Replace word with register' },
    { '<leader>v', desc = 'Edit vimrc' },

    { '<leader>f', group = 'telescope' },

    -- Leader: Buffer
    { '<leader>b', group = 'buffer' },
    { '<leader>bd', desc = 'Unload buffer' },
    { '<leader>bn', desc = 'New empty buffer' },

    -- Leader: Set
    { '<leader>s', group = 'set' },
    { '<leader>sr', desc = 'Illuminate with regex' },
    { '<leader>sl', desc = 'Illuminate with lsp' },

    -- Leader: Git
    { '<leader>g', group = 'git' },
    { '<leader>ga', desc = 'Git Add' },
    { '<leader>gb', desc = 'Git Blame' },
    { '<leader>gc', desc = 'Git Commit' },
    { '<leader>gd', desc = 'Git Diff' },
    { '<leader>gg', desc = 'Git Status (vertical)' },

    -- Leader: Toggle
    { '<leader>t', group = 'toggle' },
    { '<leader>tc', desc = 'Toggle string/comment color' },
    { '<leader>tb', desc = 'Toggle bold comments' },
    { '<leader>tt', desc = 'Toggle Treesitter context' },
    { '<leader>td', desc = 'Toggle LSP Diagnostics' },
    { '<leader>tg', desc = 'Toggle Git gutter' },
    { '<leader>ti', desc = 'Toggle Illuminate' },
    { '<leader>tj', desc = 'Toggle Fast escape (jj)' },
    { '<leader>tp', desc = 'Toggle Paste mode' },
    { '<leader>tr', desc = 'Toggle Rainbow parens' },
    { '<leader>ts', desc = 'Toggle Spell check' },
    { '<leader>tw', desc = 'Toggle Soft wrap' },

    -- Leader: Window
    { '<leader>w', group = 'window' },
    { '<leader>w=', desc = 'Balance windows' },
    { '<leader>wo', desc = 'Open in new tabpage' },
    { '<leader>wt', desc = 'Move to new tabpage' },
    { '<leader>ww', desc = 'Jump to last window' },

    -- Leader: eXecute
    { '<leader>x', group = 'execute' },
    { '<leader>xr', desc = 'Reload vimrc' },
    { '<leader>xv', desc = 'Edit vimrc' },
    { '<leader>xt', desc = 'Tabularize' },
    { '<leader>xx', desc = 'Split line by spaces' },

    -- Leader: Folds
    { '<leader>z', group = 'fold ' },
    { '<leader>ze', desc = 'method = expr' },
    { '<leader>zi', desc = 'method = indent' },
    { '<leader>zm', desc = 'method = manual' },
    { '<leader>zr', desc = 'method = market' },
    { '<leader>zz', desc = 'Check foldmethod' },
})

vim.api.nvim_set_hl(0, "WhichKeyNormal", { link = "Pmenu" })
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "WhichKeyNormal", { link = "Pmenu" })
  end,
})
