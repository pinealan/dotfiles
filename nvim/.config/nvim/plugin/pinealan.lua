--[[ Snippet ]]

vim.keymap.set({ 'i', 's' }, '<M-j>', function()
    if vim.snippet.active({ direction = 1 }) then
        vim.snippet.jump(1)
    else
        vim.snippet.stop()
    end
end, { silent = true })

vim.keymap.set({ 'i', 's' }, '<M-k>', function()
    if vim.snippet.active({ direction = -1 }) then
        vim.snippet.jump(-1)
    end
end, { silent = true })

--[[ Treesitter ]]

require('nvim-treesitter.configs').setup({
  ensure_installed = { "c", "lua", "python", "rust", "vim" },

  sync_install = false,
  auto_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    disable = {
        'clojure',
    }
  },
})

require('nvim-ts-autotag').setup()

---@type rainbow_delimiters.config
vim.g.rainbow_delimiters = {
    highlight = {
        'Delimiter',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterRed',
        'RainbowDelimiterViolet',
        'RainbowDelimiterYellow',
        'RainbowDelimiterCyan',
    },
}

vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue', { fg = '#3a5fcd' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterOrange', { fg = '#8b4500' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterGreen', { fg = '#2e8b57' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterRed', { fg = '#b22222' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', { fg = '#68228b' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', { fg = '#8b6914' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterCyan', { fg = '#b4cdcd' })

--[[ Others ]]

require("autoclose").setup({
    options = {
        disable_when_touch = true,
        disable_command_mode = true,
    },
    keys = {
        ["'"] = {
            escape = true,
            close = true,
            pair = "''",
            disabled_filetypes = {'clojure', 'markdown'}
        },
        ["`"] = {
            escape = true,
            close = true,
            pair = "``",
            disabled_filetypes = {'clojure'}
        },
    }
})
require('colorizer').setup({'*'}, {
    css = true,
})

local function config_illuminate(providers)
    require('illuminate').configure({
        delay = 20, providers = providers
    })

    for _, grp  in pairs({
        'IlluminatedWordText', 'IlluminatedWordRead', 'IlluminatedWordWrite'
    }) do
        vim.api.nvim_set_hl(0, grp, { underline = true, bg = '#4a4a4a'})
    end
end

config_illuminate({'regex'})

vim.keymap.set('n', '<leader>sr', function() config_illuminate({'regex'}) end, {})
vim.keymap.set('n', '<leader>sl', function() config_illuminate({ 'lsp', 'regex'}) end, {})

vim.keymap.set({ 'n', 'i' }, '<M-c>', require('pinealan').to_camel_case, {})
vim.keymap.set({ 'n', 'i' }, '<M-s>', require('pinealan').to_snake_case, {})

require('marks').setup({
    default_mappings = true,
    signs = true,
    mappings = {},
})

function split_string(input, separator)
    local result = {}
    for match in string.gmatch(input, "([^" .. separator .. "]+)") do
        table.insert(result, match)
    end
    return result
end

function show_rtp()
    for _, s in pairs(split_string(vim.o.rtp, ',')) do
        print(s)
    end
end

function swap_comment_string_colors()
  local cmt = vim.api.nvim_get_hl(0, { name = "Comment", link = false })
  local str = vim.api.nvim_get_hl(0, { name = "String", link = false })
  cmt.fg, str.fg = str.fg, cmt.fg
  cmt.bg, str.bg = str.bg, cmt.bg
  vim.api.nvim_set_hl(0, "Comment", cmt)
  vim.api.nvim_set_hl(0, "String", str)
  vim.notify("Swapped Comment and String colors")
end

function toggle_comment_bold()
  local hl = vim.api.nvim_get_hl(0, { name = "Comment", link = false })
  hl.bold = not hl.bold
  vim.api.nvim_set_hl(0, "Comment", hl)
  vim.notify("Comment bold: " .. (hl.bold and "ON" or "OFF"))
end

vim.api.nvim_create_user_command("SwapCommentStringColors", swap_comment_string_colors, {})
vim.api.nvim_create_user_command("ToggleCommentBold", toggle_comment_bold, {})
vim.keymap.set('n', '<leader>tc', swap_comment_string_colors)
vim.keymap.set('n', '<leader>tb', toggle_comment_bold)

--[[ Which key ]]

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

-- Normalise buffer names when reading from file
vim.opt.confirm = true
