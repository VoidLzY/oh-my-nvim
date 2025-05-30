-- ===
-- === AI助手，代码补全
-- ===
return{
    {
      'luozhiya/fittencode.nvim',
      opts = {},
        config=function ()
        require('fittencode').setup({
                -- api_key = "sk-f9413560dfd042c0a6eaf466c3b102bd", -- 设置 API 密钥
                -- model="deepseek-chat" ,
                language = "auto", -- 自动检测语言
                enable_snippets = true, -- 启用代码片段生成
                enable_completion = true, -- 启用代码补全
                enable_explanations =false, -- 启用代码解释
                enable_error_fixing =false, -- 启用错误检测与修复
                completion_trigger = "<C-x>", -- 设置补全触发快捷键
                -- inline_completion ={
                --     keymaps = {
                --             inline = {
                --           ['<TAB>'] = 'accept_all_suggestions',
                --           ['<C-Down>'] = 'accept_line',
                --           ['<C-Right>'] = 'accept_word',
                --           ['<C-Up>'] = 'revoke_line',
                --           ['<C-Left>'] = 'revoke_word',
                --           ['<A-\\>'] = 'triggering_completion',
                --         },
                --     },
                -- },
        }) 
        end
        
    }
}
