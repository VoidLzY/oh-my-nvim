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
  arrowParens: "always", // 只有一个参数的箭头函数的参数是否带圆括号（默认avoid）
  bracketSpacing: true, // 对象字面量的大括号间使用空格（默认true）
  cursorOffset: 1, // Print (to stderr) where a cursor at the given position would move to after formatting.\nThis option cannot be used with --range-start and --range-end.
  endOfLine: "lf", // Which end of line characters to apply.
  // htmlWhitespaceSensitivity: "strict",
  // insertPragma: false,
  // jsxBracketSameLine: false, // 多行JSX中的>放置在最后一行的结尾，而不是另起一行（默认false）
  // jsxSingleQuote: true,
  printWidth: 120, // 每行代码长度（默认80）
  // proseWrap: "preserve",
  // requirePragma: false,
  semi: true, // 声明结尾使用分号(默认true)
  singleQuote: false, // 使用单引号（默认false）
  tabWidth: 2, // 每个tab相当于多少个空格（默认2）
  trailingComma: "all", // 多行使用拖尾逗号（默认none）
  useTabs: false, // 是否使用tab进行缩进（默认false）
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

