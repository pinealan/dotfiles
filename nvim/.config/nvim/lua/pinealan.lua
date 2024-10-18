--[[ Configure LSP & Autocompletion ]]

local enabled_lsp = {
    'clojure_lsp',
    'pyright',
    'rust_analyzer',
    'lua_ls',
}

local lsp_capabilities = vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    require('cmp_nvim_lsp').default_capabilities()
)

local lsp = require('lspconfig')

for _, lsp_name in ipairs(enabled_lsp) do
    lsp[lsp_name].setup({
        capabilities = lsp_capabilities
    })
end

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

require('nvim-treesitter.configs').setup {
  ensure_installed = { "c", "lua", "python", "vim" },

  sync_install = false,
  auto_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  highlight = {
    enable = false,
    additional_vim_regex_highlighting = false,
  },

  playground = {
    enable = true,
    disable = {},
    updatetime = 25,
    persist_queries = false,
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}

--[[ Others ]]

require('illuminate').configure({ delay = 50, })
