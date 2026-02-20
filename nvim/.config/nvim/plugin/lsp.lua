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
    }
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

vim.lsp.enable('clojure_lsp')
vim.lsp.enable('pyright')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('ts_ls')
vim.lsp.enable('bashls')
vim.lsp.enable('vimls')

vim.lsp.enable('postgres_lsp')
vim.lsp.enable('tailwindcss')
vim.lsp.enable('lua_ls')

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(event)

        local bufnmap = function(keys, func)
            vim.keymap.set('n', keys, func, { buffer = event.buf })
        end

        bufnmap('K', function() vim.lsp.buf.hover({
            max_width = 100, wrap = true, wrap_at = 98
        }) end)
        bufnmap('gd', function() vim.lsp.buf.definition({ reuse_win = true }) end)
        bufnmap('g<C-d>', function() vim.cmd('tab sp'); vim.lsp.buf.definition() end)
        bufnmap('gi', function() vim.lsp.buf.implementation({ reuse_win = true }) end)
        bufnmap('gr', vim.lsp.buf.references)
        bufnmap('gC', vim.lsp.buf.incoming_calls)
        bufnmap('gD', vim.lsp.buf.declaration)
        bufnmap('gt', function() vim.lsp.buf.type_definition({ reuse_win = true }) end)

        bufnmap('<leader>H', vim.lsp.buf.signature_help)
        bufnmap('<leader>R', vim.lsp.buf.rename)
        bufnmap('<leader>A', vim.lsp.buf.code_action)
        bufnmap('<leader>D', vim.diagnostic.open_float)
        bufnmap('<leader>F', vim.diagnostic.setloclist)
        bufnmap('<leader>Q', vim.diagnostic.setqflist)
        bufnmap('<M-[>', function() vim.diagnostic.jump({count=-1, float=true}) end)
        bufnmap('<M-]>', function() vim.diagnostic.jump({count=1, float=true}) end)
    end
});
