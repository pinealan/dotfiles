-- Copied from reddit
-- https://www.reddit.com/r/neovim/comments/1cxfhom/builtin_snippets_so_good_i_removed_luasnip/

local M = {}

local global_snippets = {
    {trigger = 'shebang', body = '#!/bin sh'}
}

local rust_test_module_snippet = '#[cfg(test)]\nmod tests {\n    use super::*;    \n\n#[test]\nfn test_$1() {$2}}'

local snippets_by_filetype = {
    lua = {
        { trigger = 'function', body = 'function ${1:name}(${2:args}) $0 end' },
    },
    clojure = {
        { trigger = 'css', body = '{:class "${1}"} ' },
        { trigger = 'attr', body = '{:${1} "${2}"}' },
        { trigger = '(comment', body = '(comment\n  $0)' },
        { trigger = 'const-def', body = '(def ^:const $1 $2)' },
        { trigger = ':keys-destruct', body = '{:keys [$2]}${1: }' },
        { trigger = '(try', body = '(try $3 (catch ${1:Exception} ${2:e} $4)) ' },
    },
    python = {
        { trigger = 'def', body = 'def $1($2) -> $3:\n$0' },
        { trigger = 'class', body = 'class $1 -> $3:\n$0' },
        { trigger = 'init', body = 'def __init__(self$1):$0' },
        { trigger = 'repr', body = 'def __repr__(self$1):$0' },
        { trigger = 'context', body = 'def __enter__(self):\npassdef __exit__(self):\npass' },
    },
    rust = {
        { trigger = 'print_debug', body = 'println!("{:?}", $1);' },
        { trigger = 'pprint_debug', body = 'println!("{:#?}", $1);' },
        { trigger = ': vec', body = ': Vec<${1:_}>' },
        { trigger = 'lambda', body = '|${1:x}| ${2:x}' },
        { trigger = 'modtest', body = rust_test_module_snippet },
        { trigger = 'testmod', body = rust_test_module_snippet },
        { trigger = 'testfn', body = '#[test]\nfn test_$1()\n{$2}' },
    }
}

local function get_buf_snips()
    local ft = vim.bo.filetype
    local snips = vim.list_slice(global_snippets)

    if ft and snippets_by_filetype[ft] then
        vim.list_extend(snips, snippets_by_filetype[ft])
    end

    return snips
end

-- cmp source for snippets to show up in completion menu
M.register_cmp_source = function()
    local cmp_source = {}
    local cache = {}
    function cmp_source.complete(_, _, callback)
        local bufnr = vim.api.nvim_get_current_buf()
        if not cache[bufnr] then
            local completion_items = vim.tbl_map(function(s)
                ---@type lsp.CompletionItem
                local item = {
                    word = s.trigger,
                    label = s.trigger,
                    kind = vim.lsp.protocol.CompletionItemKind.Snippet,
                    insertText = s.body,
                    insertTextFormat = vim.lsp.protocol.InsertTextFormat.Snippet,
                }
                return item
            end, get_buf_snips())

            cache[bufnr] = completion_items
        end

        callback(cache[bufnr])
    end

    require('cmp').register_source('snp', cmp_source)
end

return M
