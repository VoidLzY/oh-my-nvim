-- ~/.config/nvim/lua/custom/init_project.lua

local M = {}

M.prettierrc_init_project = function()
  -- 获取当前工作目录
  local cwd = vim.fn.getcwd()
  -- 设置 .prettierrc.js 文件路径
  local file_path = cwd .. '/.prettierrc.js'

  -- 检查文件是否已经存在
  if vim.fn.filereadable(file_path) == 1 then
    print('.prettierrc.js already exists')
    return
  end

  -- 预定义的 .prettierrc.js 内容
  local content = [[
module.exports = {
  semi: true,
  singleQuote: true,
  trailingComma: 'all',
  printWidth: 80,
  tabWidth: 2,
};
]]

  -- 将内容写入 .prettierrc.js 文件
  local file = io.open(file_path, "w")
  if file then
    file:write(content)
    file:close()
    print('.prettierrc.js created successfully')
  else
    print('Failed to create .prettierrc.js')
  end
end

return M

