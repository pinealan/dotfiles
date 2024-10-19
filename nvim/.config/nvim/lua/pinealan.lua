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

--[[ Autocompletion ]]

require('cmp').setup({
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
