local function neovidesetting()
    if vim.g.neovide then
        -- 缩放至0.85
        vim.g.neovide_scale_factor = 0.85
        -- floating blur amount 好像没啥用
        vim.g.neovide_floating_blur_amount_x = 2.0
        vim.g.neovide_floating_blur_amount_y = 2.0
        -- floating  shodow 好像也没啥用
        vim.g.neovide_floating_shadow = true;
        vim.g.neovide_floating_z_height = 10
        vim.g.neovide_light_angle_degrees = 45
        vim.g.neovide_light_radius = 5
        -- scroll animation length 滚动时间
        vim.g.neovide_animation_length = 0.2
        -- hiding th mouse when typing 打字时隐藏鼠标
        vim.g.neovide_hide_mouse_when_typing = true
        -- cursor particles 鼠标特效
        vim.g.neovide_cursor_vfx_mode = "railgun"
    end
end

local function neovidekeymapsetting()
    if vim.g.neovide then
        vim.keymap.set('v', 'c-c', '"+y')         -- copy
        vim.keymap.set('n', 'c-v', '"+p')         -- paste normal mode
        vim.keymap.set('v', 'c-v', '"+p')         -- paste visual mode
        vim.keymap.set('c', 'c-v', '<c-r>+')      -- paste command mode
        vim.keymap.set('i', 'c-v', '<ecs>l"+pli') -- paste insert mode
    end
end

vim.g.neovide_scale_factor = 1.0
local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
local function set_neovide_scale_factor()
    vim.keymap.set("n", "<c-=>", function()
        change_scale_factor(1.25)
    end)
    vim.keymap.set("n", "<c-->", function()
        change_scale_factor(1 / 1.25)
    end)
end


neovidesetting()
neovidekeymapsetting()
set_neovide_scale_factor()
