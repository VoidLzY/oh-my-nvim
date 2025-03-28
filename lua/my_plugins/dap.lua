return {
     -- 安装 nvim-dap 及其 UI 插件
  "mfussenegger/nvim-dap",                       --DAP核心功能
  "theHamsta/nvim-dap-virtual-text",             --调试时显示变量值
  {
    "rcarriga/nvim-dap-ui",                      --DAP UI插件
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
local keys =require("custom_keys")

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

dap.adapters["pwa-node"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
                command = "node",
                -- 💀 Make sure to update this path to point to your installation
                args = {"C:/Users/bai/game_develop/js-debug/src/dapDebugServer.js", "${port}"},
              }
        }

dap.configurations.typescript = {
          {
            type = 'pwa-node',
            request = 'launch',
            name = "Launch file",
            runtimeExecutable = "deno",
            runtimeArgs = {
                  "run",
                  "--inspect-wait",
                  "--allow-all"
                    },
            program = "${file}",
            cwd = "${workspaceFolder}",
            attachSimplePort = 9229,
          },
    }
    vim.keymap.set('n', keys.start_dap, function() dap.continue() end)
    vim.keymap.set('n',  keys.step_over, function() dap.step_over() end)
    vim.keymap.set('n', keys.step_into, function() dap.step_into() end)
    vim.keymap.set('n', keys.step_out, function() dap.step_out() end)
    vim.keymap.set('n', keys.toggle_breakpoint, function() dap.toggle_breakpoint() end)
    vim.keymap.set('n', keys.set_breakpoint, function() dap.set_breakpoint() end)
    vim.keymap.set('n', keys.log_breakpoints, function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
    vim.keymap.set('n', keys.repl_open, function() dap.repl.open() end)
    vim.keymap.set('n', keys.run_last, function() dap.run_last() end)
end,

    


}
