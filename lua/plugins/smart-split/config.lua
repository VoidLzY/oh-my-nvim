return function()
    require('smart-splits').setup({
        ignored_filetypes = {
            'nofile',
            'quickfix',
            'prompt',
            'neo-tree',
        },
        ignored_buftypes = { 'NvimTree', 'neo-tree' },
    })

    local keys = require("custom_keys")
    local option = {noremap = true, silent = true }

    option.desc = "Window Move left"
    vim.keymap.set({'n', 't'}, keys.resize_left, require('smart-splits').resize_left, option)
    option.desc = "Window Move down"
    vim.keymap.set({'n', 't'}, keys.resize_down, require('smart-splits').resize_down, option)
    option.desc = "Window Move up"
    vim.keymap.set({'n', 't'}, keys.resize_up, require('smart-splits').resize_up, option)
    option.desc = "Window Move right"
    vim.keymap.set({'n', 't'}, keys.resize_right, require('smart-splits').resize_right, option)
end
