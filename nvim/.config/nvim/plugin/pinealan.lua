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
vim.keymap.set('n', '<leader>ta', swap_comment_string_colors)
vim.keymap.set('n', '<leader>tb', toggle_comment_bold)

-- Normalise buffer names when reading from file
vim.opt.confirm = true
