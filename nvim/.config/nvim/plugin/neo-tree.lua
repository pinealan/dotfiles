--- Neo-tree

require("neo-tree").setup({
    sources = {
        "filesystem",
        "buffers",
        "git_status",
        "document_symbols",
    },
    enable_diagnostics = true,
    enable_git_status = true,
    enable_cursor_hijack = true,
    default_component_configs = {
        indent = {
            with_expanders = false,
            expander_collapsed = "+",
            expander_expanded = "-",
        },
        icon = {
            folder_closed = "+",
            folder_open = "-",
            folder_empty = "=",
            folder_empty_open = "@",
        },
        git_status = {
            symbols = {
                added     = "",
                deleted   = "",
                modified  = "",
                renamed   = "",
                -- Status type
                untracked = "?",
                ignored   = "",
                unstaged  = "",
                staged    = "S",
                conflict  = "!",
            },
        },
    },
    window = {
        mappings = {
            ["Z"] = "expand_all_nodes",
            ["="] = "toggle_node",
        },
    },
    document_symbols = {
        follow_cursor = false,
        kinds = {
          Unknown = { icon = "?", hl = "" },
          Root = { icon = "*", hl = "NeoTreeRootName" },
          File = { icon = "F", hl = "Identifier" },
          Module = { icon = "M", hl = "Include" },
          Namespace = { icon = "N", hl = "Include" },
          Package = { icon = "P", hl = "Label" },
          Class = { icon = "C", hl = "Include" },
          Method = { icon = "m", hl = "Function" },
          Property = { icon = "p", hl = "@property" },
          Field = { icon = "p", hl = "@field" },
          Constructor = { icon = "x", hl = "@constructor" },
          Enum = { icon = "E", hl = "@number" },
          Interface = { icon = "I", hl = "Type" },
          Function = { icon = "f", hl = "Function" },
          Variable = { icon = "v", hl = "@variable" },
          Constant = { icon = "c", hl = "Constant" },
          String = { icon = "s", hl = "String" },
          Number = { icon = "n", hl = "Number" },
          Boolean = { icon = "b", hl = "Boolean" },
          Array = { icon = "A", hl = "Special" },
          Object = { icon = "O", hl = "Special" },
          Key = { icon = "k", hl = "" },
          Null = { icon = "0", hl = "Constant" },
          EnumMember = { icon = "n", hl = "Number" },
          Struct = { icon = "S", hl = "Type" },
          Event = { icon = "e", hl = "Constant" },
          Operator = { icon = "r", hl = "Operator" },
          TypeParameter = { icon = "t", hl = "Type" },
        }
    }
})

vim.keymap.set('n', '<M-1>', ':Neotree filesystem left<cr>', { noremap = true})
vim.keymap.set('n', '<M-2>', ':Neotree document_symbols right<cr>', { noremap = true})

vim.api.nvim_set_hl(0, '@field', { link = 'Identifier' })
vim.api.nvim_set_hl(0, '@property', { link = 'Identifier' })

