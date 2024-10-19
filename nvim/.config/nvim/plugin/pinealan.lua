--[[ LSP ]]

local lsp_capabilities = vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    require('cmp_nvim_lsp').default_capabilities()
)

local lsp = require('lspconfig')

lsp['clojure_lsp'].setup({
    capabilities = lsp_capabilities
})
lsp['pyright'].setup({
    capabilities = lsp_capabilities
})
lsp['rust_analyzer'].setup({
    capabilities = lsp_capabilities
})
lsp['vimls'].setup({
    capabilities = lsp_capabilities
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

local cmp = require('cmp')

cmp.setup({
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },
    sources = {
        {name = 'path'},
        {name = 'nvim_lsp', keyword_length = 1},
        {name = 'buffer', keyword_length = 3},
    },
    mapping = cmp.mapping.preset.insert({
        -- Supposedly "old-school" way of navigating vim completion menu,
        -- according to :ins-completion
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-e>'] = cmp.mapping.abort(),

        -- More typical way with using Tabs
        ['<tab>']   = cmp.mapping.select_next_item(),
        ['<S-tab>'] = cmp.mapping.select_prev_item(),
        ['<cr>']    = cmp.mapping.confirm { select = true },
        ['<esc>']   = cmp.mapping.abort(),
    }),
    completion = {
        completeopt = 'menu,menuone,noinsert',
    },
})

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
  },
})

--[[ Others ]]

require('illuminate').configure({ delay = 50, })
