--- Autocompletion configs

require('my_snippets').register_cmp_source()

-- Disable builtin cmdline-completion
vim.o.wildmenu = false
vim.o.wildchar = 0

vim.o.completeopt = 'menu,menuone,noinsert'

local cmp = require('cmp')
local cmp_menu_name = {
    snp = '[SNIP]',
    nvim_lsp = '[LSP]',
    buffer = '[BUF]',
    cmdline = '[CMD]',
    async_path = '[PATH]',
}
local cmp_buffer_source = {
    name = 'buffer',
    keyword_pattern = [[\k\+]],
    option = {
        keyword_pattern = [[\k\+]],
    },
}
local cmp_mapping = {
    ['<C-n>'] = cmp.mapping(
        cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        { 'i', 'c' }
    ),
    ['<C-p>'] = cmp.mapping(
        cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        { 'i', 'c' }
    ),
    ['<C-e>'] = cmp.mapping(
        cmp.mapping.abort(),
        { 'i', 'c' }
    ),
    ['<C-y>'] = {
        i = cmp.mapping.confirm({ select = true }),
        c = cmp.mapping.confirm(),
    },
    ['<C-space>'] = {
        c = cmp.mapping.complete()
    },

    -- Aliases
    ['<tab>'] = cmp.mapping(
        cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        { 'i', 'c' }
    ),
    ['<S-tab>'] = cmp.mapping(
        cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        { 'i', 'c' }
    ),
    ['<C-k>'] = {
        i = cmp.mapping.confirm({ select = true }),
        c = cmp.mapping.confirm(),
    },

    -- Item docs
    ['<M-k>'] = { i = cmp.mapping.open_docs() },
    ['<M-K>'] = { i = cmp.mapping.close_docs() },
    ['<C-d>'] = { i = cmp.mapping.scroll_docs(4) },
    ['<C-u>'] = { i = cmp.mapping.scroll_docs(-4) },
}

cmp.setup({
    completion = {
        -- Default to off
        -- autocomplete = false,
        keyword_pattern = [[\k\+]],
        keyword_length = 2,
    },
    formatting = {
        format = function (cmp_entry, vim_item)
            vim_item.menu = cmp_menu_name[cmp_entry.source.name] or cmp_entry.source.name
            return vim_item
        end,
    },
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },
    sources = {
        {
            name = 'snp',
            keyword_length = 2,
        },
        {
            name = 'nvim_lsp',
            keyword_pattern = [[\k\+]],
            keyword_length = 1,
            option = {
                keyword_pattern = [[\k\+]],
            },
        },
        { name = 'nvim_lsp_signature_help' },
        cmp_buffer_source,
    },
    mapping = cmp_mapping,
    preselect = cmp.PreselectMode.None,
    window = {
        completion = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = 'Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None',
            max_height = 15,
        }),
        documentation = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = 'Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None',
            max_height = 15,
        }),
    },
})

cmp.setup.cmdline({'/', '?'}, {
    completion = { keyword_length = 2, },
    sources = {
        cmp_buffer_source,
    },
    preselect = cmp.PreselectMode.None,
    view = { entries = { name = 'wildmenu', separator = ' | ' } },
})

cmp.setup.cmdline(':', {
    completion = { keyword_length = 1, },
    sources = cmp.config.sources({
        {
            name = 'async_path',
            option = {
                show_hidden_files_by_default = true
            },
            entry_filter = function(entry, _ctx)
                if entry.word == '__pycache__' then
                    return false
                else
                    return true
                end
            end,
        }
    }, {
        {
            name = 'cmdline',
            keyword_length = 1,
            option = {
                ignore_cmds = { "Man", "!", "edit", "write" }
            }
        },
        cmp_buffer_source,
    }),
    preselect = cmp.PreselectMode.Item,
    window = {
        completion = {
            border = "none",
            winhighlight = 'Normal:Pmenu,CursorLine:PmenuSel,Search:None'
        }
    }
})

vim.api.nvim_set_hl(0, 'CmpItemKindClass', { link = 'Type' })
vim.api.nvim_set_hl(0, 'CmpItemKindField', { link = 'Identifier' })
vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link = 'Function' })
vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { link = 'Identifier' })
vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { link = 'Function' })
vim.api.nvim_set_hl(0, 'CmpItemKindSnippet', { link = 'Macro' })
vim.api.nvim_set_hl(0, 'CmpItemKindModule', { link = 'Include' })
vim.api.nvim_set_hl(0, 'CmpItemKindFile', { link = 'String' })


-- Taken from https://github.com/gitaarik/nvim-cmp-toggle/blob/main/plugin/nvim_cmp_toggle.lua
local function toggle_autocomplete()
  local current_setting = cmp.get_config().completion.autocomplete
  if current_setting and #current_setting > 0 then
    cmp.setup({ completion = { autocomplete = false } })
    vim.notify('Autocomplete disabled')
  else
    cmp.setup({ completion = { autocomplete = { cmp.TriggerEvent.TextChanged } } })
    vim.notify('Autocomplete enabled')
  end
end

vim.api.nvim_create_user_command('NvimCmpToggle', toggle_autocomplete, {})
vim.keymap.set('n', '<leader>ta', toggle_autocomplete, { desc = 'Autocomplete' })
