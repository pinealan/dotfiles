--- Telescope

local telescope = require('telescope')
local t = require('telescope.builtin')
local actions = require('telescope.actions')

telescope.setup({
    defaults = {
        mappings = {
            i = {
                ['<esc>'] = actions.close,
                ['<up>'] = nil,
                ['<down>'] = nil,
            },
        },
        layout_strategy = 'flex',
        layout_config = {
            flip_columns = 120,
            vertical = {
                preview_cutoff = 40,
                preview_height = 0.7,
            },
            horizontal = {
                width = 170,
                preview_cutoff = 0,
                preview_width = { 9 / 16, min = 70 , max = 90 },
            }
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

vim.keymap.set('n', '<leader>fC', t.commands, { desc = 'Commands' })
vim.keymap.set('n', '<leader>fc', t.command_history, { desc = 'Command history' })
vim.keymap.set('n', '<leader>fe', t.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>fF', t.find_files, { desc = 'Files' })
vim.keymap.set('n', '<leader>fk', t.keymaps, { desc = 'Keymaps' })
vim.keymap.set('n', '<leader>fl', t.lsp_document_symbols, { desc = 'LSP symbols' })
vim.keymap.set('n', '<leader>fm', t.marks, { desc = 'Marks' })
vim.keymap.set('n', '<leader>fr', t.registers, { desc = 'Registers' })
vim.keymap.set('n', '<leader>fs', t.live_grep, { desc = 'Grep string' })
vim.keymap.set('n', '<leader>f*', t.grep_string, { desc = 'Grep string under cursor' })

vim.keymap.set('n', '<leader>ff', require('pinealan').project_files, { desc = 'Project files' })
vim.keymap.set('n', '<leader>fg',
    function() t.git_commits({ "git", "log", "--pretty=format:%h %as %s", "--abbrev-commit", "--", "." }) end,
    { desc = 'List commits' })
vim.keymap.set('n', '<leader>fh',
    function() t.git_bcommits({ "git", "log", "--pretty=format:%h %as %s", "--abbrev-commit", "--follow" }) end,
    { desc = 'List commits for current buffer' })
