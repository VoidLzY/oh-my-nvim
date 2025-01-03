return {
     -- 安装 nvim-dap 及其 UI 插件
  "mfussenegger/nvim-dap",
  "theHamsta/nvim-dap-virtual-text",
  {
    "rcarriga/nvim-dap-ui",
    requires = { "mfussenegger/nvim-dap" }
  },

  -- 安装 telescope-dap.nvim 插件
  {
    "nvim-telescope/telescope-dap.nvim",
    requires = { "nvim-telescope/telescope.nvim" },
  },
  config = function()
    -- 加载 telescope 和 telescope-dap
require('telescope').load_extension('dap')

-- 配置 nvim-dap 和 nvim-dap-ui
local dap = require('dap')
local dapui = require('dapui')

dapui.setup()

-- 在调试会话开始和结束时自动打开和关闭 dapui
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
    end,

}
