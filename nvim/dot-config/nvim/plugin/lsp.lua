--- LSP configs

vim.lsp.config('*', {
    capablities = require('cmp_nvim_lsp').default_capabilities()
})

vim.lsp.config('postgres_lsp', {
    filetypes = {
        'sql', 'psql', 'pgsql',
    },
})

vim.lsp.config('pyright', {
    root_markers = {
        'pyproject.toml',
        'setup.py',
        'setup.cfg',
        'Pipfile',
        'pyrightconfig.json',
    },
    settings = {
        -- use ruff for import organisation
        disableOrganizeImports = true,
    }
})

vim.lsp.config('ruff', {
    on_attach = function (client, _)
        -- use pyright for hover/autocomplete
        client.server_capabilities.hoverProvider = false
    end,
})

vim.lsp.config('rust_analyzer', {
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                features = 'all'
            },
        }
    }
})

vim.lsp.config('tailwindcss', {
    filetypes = {
        'clojure', 'html', 'css', 'javascriptreact', 'typescriptreact',
    },
})

vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT'
            },
            diagnostics = {
                globals = { 'vim', 'require' },
                disable = { 'missing-fields', 'lowercase-global' }
            },
            format = {
                defaultConfig = {
                    max_line_length = 100,
                },
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

vim.lsp.enable({
    'clojure_lsp',
    'pyright',
    'ruff',
    'rust_analyzer',
    'ts_ls',
    'bashls',
    'vimls',
    'postgres_lsp',
    'tailwindcss',
    'lua_ls',
})

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(event)

        local bufnmap = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
        end

        bufnmap('K', function() vim.lsp.buf.hover({ max_width = 100, wrap = true, wrap_at = 98 }) end, 'LSP: Quick docs')
        bufnmap('gd', function() vim.lsp.buf.definition({ reuse_win = true }) end, 'LSP: Goto definition')
        bufnmap('g<C-d>', function() vim.cmd('tab sp'); vim.lsp.buf.definition() end, 'LSP: Goto definition in new tabpage')
        bufnmap('gi', function() vim.lsp.buf.implementation({ reuse_win = true }) end, 'LSP: Goto implementation')
        bufnmap('gr', vim.lsp.buf.references, 'LSP: Goto refrences')
        bufnmap('gC', vim.lsp.buf.incoming_calls, 'LSP: Goto incoming calls')
        bufnmap('gD', vim.lsp.buf.declaration, 'LSP: Goto declaration')
        bufnmap('gt', function() vim.lsp.buf.type_definition({ reuse_win = true }) end, 'LSP: Goto type declaration')

        bufnmap('<leader>A', vim.lsp.buf.code_action, 'LSP: code action')
        bufnmap('<leader>H', vim.lsp.buf.signature_help, 'LSP: Show signature help')
        bufnmap('<leader>R', vim.lsp.buf.rename, 'LSP: Rename symbol under cursor')
        bufnmap('<leader>D', vim.diagnostic.open_float, 'LSP: Open diagnostics in floating window')
        bufnmap('<leader>F', vim.diagnostic.setloclist, 'LSP: Send diagnostics to loclist')
        bufnmap('<leader>Q', vim.diagnostic.setqflist, 'LSP: Send diagnostics to quickfix')
        bufnmap('<M-[>', function() vim.diagnostic.jump({count=-1, float=true}) end)
        bufnmap('<M-]>', function() vim.diagnostic.jump({count=1, float=true}) end)
    end
});
