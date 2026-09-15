--- Treesitter and TS dependent plugins

require('nvim-treesitter.configs').setup({
  ensure_installed = { "c", "lua", "python", "rust", "vim" },

  sync_install = false,
  auto_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  highlight = {
    enable = true,
  },
})

require 'treesitter-context' .setup({
    enable = true,
    min_window_height = 30,
    line_numbers = false,
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

vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue',   { fg = '#3a5fcd' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterOrange', { fg = '#8b4500' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterGreen',  { fg = '#2e8b57' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterRed',    { fg = '#b22222' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', { fg = '#68228b' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', { fg = '#8b6914' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterCyan',   { fg = '#b4cdcd' })

local function config_illuminate(providers)
    require('illuminate').configure({
        delay = 20,
        providers = providers,
        under_cursor = true,
    })
end

config_illuminate({'regex'})

vim.keymap.set('n', '<leader>sr', function() config_illuminate({'regex'}) end, {})
vim.keymap.set('n', '<leader>sl', function() config_illuminate({ 'lsp', 'regex'}) end, {})
