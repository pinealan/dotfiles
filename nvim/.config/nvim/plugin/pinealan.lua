--[[ LSP ]]

local lsp_capabilities = vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    require('cmp_nvim_lsp').default_capabilities()
)

local lsp = require('lspconfig')

lsp['clojure_lsp'].setup({ capabilities = lsp_capabilities })
lsp['pyright'].setup({ capabilities = lsp_capabilities })
lsp['rust_analyzer'].setup({ capabilities = lsp_capabilities })
lsp['ts_ls'].setup({ capabilities = lsp_capabilities })
lsp['bashls'].setup({ capabilities = lsp_capabilities })
lsp['vimls'].setup({ capabilities = lsp_capabilities })

lsp['postgres_lsp'].setup({
    capabilities = lsp_capabilities,
    filetypes = {
        'sql', 'psql',
    },
})

lsp['tailwindcss'].setup({
    capabilities = lsp_capabilities,
    filetypes = {
        'clojure', 'html', 'css', 'javascriptreact', 'typescriptreact',
    },
})

lsp['lua_ls'].setup({
    capabilities = lsp_capabilities,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT'
            },
            diagnostics = {
                globals = { 'vim', 'require' },
                disable = { 'missing-fields' }
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true)
            },
            telemetry = {
                enable = false,
            },
        },
    },
})

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(event)

        local bufnmap = function(keys, func)
            vim.keymap.set('n', keys, func, { buffer = event.buf })
        end

        bufnmap('K', vim.lsp.buf.hover)
        bufnmap('gd', vim.lsp.buf.definition)
        bufnmap('gi', vim.lsp.buf.implementation)
        bufnmap('gr', vim.lsp.buf.references)
        bufnmap('gD', vim.lsp.buf.declaration)
        bufnmap('go', vim.lsp.buf.type_definition)

        bufnmap('<leader>H', vim.lsp.buf.signature_help)
        bufnmap('<leader>R', vim.lsp.buf.rename)
        bufnmap('<leader>ca', vim.lsp.buf.code_action)
        bufnmap('<leader>l', vim.diagnostic.open_float)
        bufnmap('<leader>[', vim.diagnostic.goto_prev)
        bufnmap('<leader>]', vim.diagnostic.goto_next)
    end
});

--[[ Autocompletion ]]

require('my_snippets').register_cmp_source()
local cmp = require('cmp')

cmp.setup({
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },
    sources = {
        {name = 'path', keyword_length = 5},
        {name = 'nvim_lsp', keyword_length = 4},
        {name = 'buffer', keyword_length = 3},
        {name = 'snp', keyword_length = 3},
    },
    mapping = cmp.mapping.preset.insert({
        ['<tab>']   = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<S-tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<cr>']    = cmp.mapping.confirm { select = true },
        ['<esc>']   = cmp.mapping.abort(),
    }),
    preselect = cmp.PreselectMode.None,
})

--[[ Snippet ]]

vim.keymap.set({ 'i', 's' }, '<C-j>', function()
    if vim.snippet.active({ direction = 1 }) then
        vim.snippet.jump(1)
    else
        vim.snippet.stop()
    end
end, { silent = true })

vim.keymap.set({ 'i', 's' }, '<C-k>', function()
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

--[[ Telescope ]]

local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup({
    defaults = {
        mappings = {
            i = {
                ['<esc>'] = actions.close,
            },
        },
        layout_config = {
            width = 160,
            preview_width = 92,
        },
    },
    pickers = {
        buffers = {
            mappings = {
                i = {
                    ['<M-d>'] = actions.delete_buffer,
                }
            }
        }
    }
})

telescope.load_extension('fzf')

--[[ Others ]]

require("autoclose").setup({
    keys = {
        ["'"] = {
            escape = true, close = true, pair = "''",
            disabled_filetypes = {'clojure'}
        },
        ["`"] = {
            escape = true, close = true, pair = "``",
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

vim.keymap.set('n', '<leader>sr', function()
    config_illuminate({'regex'})
end, {})
vim.keymap.set('n', '<leader>sl', function()
    config_illuminate({ 'lsp', 'regex'})
end, {})

if vim.g.neovide then
    vim.g.neovide_input_macos_option_key_is_meta = 'only_left'
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_scale_factor = 1.05

    -- Reduce animations
    -- https://neovide.dev/faq.html#how-to-turn-off-all-animations
    vim.g.neovide_cursor_animation_length = 0.00
    vim.g.neovide_cursor_trail_size = 0
    vim.g.neovide_cursor_animate_in_insert_mode = false
    vim.g.neovide_cursor_animate_command_line = false
    vim.g.neovide_position_animation_length = 0.04
    vim.g.neovide_scroll_animation_length = 0.07

    -- Copy paste
    -- https://neovide.dev/faq.html#how-can-i-use-cmd-ccmd-v-to-copy-and-paste
    vim.keymap.set('v', '<D-c>', 'y', { noremap = true })
    vim.keymap.set({'n', 'v'}, '<D-v>', 'p', { noremap = true })
    vim.keymap.set('v', '<D-v>', 'p', { noremap = true })
    vim.keymap.set('c', '<D-v>', '<C-R>+', { noremap = true })
    vim.keymap.set('i', '<D-v>', '<ESC>pa', { noremap = true })

    -- Change scale (like vimr)
    -- https://neovide.dev/faq.html#how-can-i-dynamically-change-the-scale-at-runtime
    local change_scale_factor = function(delta)
      vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    vim.keymap.set("n", "<D-=>", function() change_scale_factor(1.05) end)
    vim.keymap.set("n", "<D-->", function() change_scale_factor(1/1.05) end)
end
