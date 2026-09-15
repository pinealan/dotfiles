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

--[[ Colorizer for CSS ]]

require('colorizer').setup({'*'}, {
    css = true,
})

vim.keymap.set('n', '<leader>tz',
    function() vim.cmd('ColorizerToggle') end, { desc = 'Toggle colorizer'})

--[[ Autoclose ]]

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

--[[ Marks ]]

require('marks').setup({
    default_mappings = true,
    signs = false,
    mappings = {},
})

--[[ Notify ]]

require("notify").setup({
    stages = 'static',
    icons = {
      DEBUG = "⚙️",
      ERROR = "E",
      INFO = "ⓘ",
      TRACE = "T",
      WARN = "W"
    },
})

vim.g.notify_original = vim.notify
function toggle_notify()
    if vim.notify == vim.g.notify_original then
        vim.notify = require("notify")
    else
        vim.notify = vim.g.notify_original
    end
end

vim.notify = require("notify")

--[[ oil ]]
require('oil').setup({
    columns = {
        -- 'icon',
        -- 'permissions',
        'size',
        'mtime'
    },
    skip_confirm_for_simple_edits = true,
    view_options = {
        show_hidden = true,
    },
})


--[[ Keyamps / Functions / Commands ]]

vim.keymap.set({ 'n', 'i' }, '<M-c>', require('pinealan').to_camel_case, {})
vim.keymap.set({ 'n', 'i' }, '<M-s>', require('pinealan').to_snake_case, {})

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

--- Dynamically change highlight links

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

-- Hook up command and keymap to the functions
vim.api.nvim_create_user_command("SwapCommentStringColors", swap_comment_string_colors, {})
vim.api.nvim_create_user_command("ToggleCommentBold", toggle_comment_bold, {})
vim.keymap.set('n', '<leader>tc', swap_comment_string_colors)
vim.keymap.set('n', '<leader>tb', toggle_comment_bold)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "<CR>", function()
      vim.cmd(".cc")
    end, { buffer = true, silent = true })
  end,
})

--[[ Options ]]

-- Normalise buffer names when reading from file
vim.opt.confirm = true
