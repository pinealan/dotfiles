require('which-key').add({
    { '<localleader><Tab>', desc = 'Goto corresponding src/test file' },
    { '<localleader>rc', desc = 'Ruff check' },
    { '<localleader>rf', desc = 'Ruff format' },
})

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.py",
    callback = function(ev)
        vim.system({ "ruff", "format", ev.match }, {}, function()
            vim.schedule(function()
                vim.cmd("checktime")
            end)
        end)
    end,
})
