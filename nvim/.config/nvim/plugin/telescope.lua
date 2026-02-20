--- Telescope

local telescope = require('telescope')
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
