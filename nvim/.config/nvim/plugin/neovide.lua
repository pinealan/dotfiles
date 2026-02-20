--- Neovide

if vim.g.neovide then
    vim.g.neovide_input_macos_option_key_is_meta = 'only_left'
    --vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_scale_factor = 1.05

    -- Reduce animations
    -- https://neovide.dev/faq.html#how-to-turn-off-all-animations
    vim.g.neovide_cursor_animation_length = 0.00
    vim.g.neovide_cursor_trail_size = 0
    vim.g.neovide_cursor_animate_in_insert_mode = false
    vim.g.neovide_cursor_animate_command_line = false
    vim.g.neovide_position_animation_length = 0.04
    vim.g.neovide_scroll_animation_length = 0.07

    -- Copy paste
    -- https://neovide.dev/faq.html#how-can-i-use-cmd-ccmd-v-to-copy-and-paste
    vim.keymap.set('v', '<D-c>', 'y', { noremap = true })
    vim.keymap.set({'n', 'v'}, '<D-v>', 'p', { noremap = true })
    vim.keymap.set('v', '<D-v>', 'p', { noremap = true })
    vim.keymap.set('c', '<D-v>', '<C-R>+', { noremap = true })
    vim.keymap.set('i', '<D-v>', '<ESC>pa', { noremap = true })

    -- Change scale (like vimr)
    -- https://neovide.dev/faq.html#how-can-i-dynamically-change-the-scale-at-runtime
    local print_scale = function()
        vim.print('Zoom: ' .. tostring(vim.g.neovide_scale_factor))
    end

    local change_scale_factor = function(delta)
      vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
      vim.defer_fn(print_scale, 50)
    end

    vim.keymap.set("n", "<D-=>", function() change_scale_factor(1.05) end)
    vim.keymap.set("n", "<D-->", function() change_scale_factor(1/1.05) end)

    vim.keymap.set("n", "<D-+>", function() change_scale_factor(1.1025) end)
    vim.keymap.set("n", "<D-_>", function() change_scale_factor(1/1.1025) end)
end

-- Neovide respects these options for window title
vim.opt.title = true
vim.opt.titlestring = vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
