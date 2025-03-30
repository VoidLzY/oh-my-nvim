-- UI responsiveness
local dap, dapui ,keys= require 'dap', require 'dapui',require("custom_keys")

-- 在调试会话开始和结束时自动打开和关闭 dapui
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

-- customize UI layout
dapui.setup {
  layouts = {
    {
      position = 'left',
      size = 0.4,
      elements = {
        { id = 'stacks', size = 0.2 },
        { id = 'scopes', size = 0.5 },
        { id = 'breakpoints', size = 0.15 },
        { id = 'watches', size = 0.15 },
      },
    },
    {
      position = 'bottom',
      size = 0.2,
      elements = {
        { id = 'repl', size = 0.3 },
        { id = 'console', size = 0.7 },
      },
    },
  },
}

-- Custom breakpoint icons
vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = 'DapBreakpoint' })
vim.fn.sign_define(
  'DapBreakpointCondition',
  { text = '', texthl = 'DapBreakpointCondition', linehl = 'DapBreakpointCondition', numhl = 'DapBreakpointCondition' }
)
vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })

-- keymaps
vim.keymap.set('n', keys.dap_toggle_ui, dapui.toggle, { desc = 'DAP: Toggle UI' })
vim.keymap.set('n', keys.start_dap, dap.continue, { desc = ' Start/Continue' })
vim.keymap.set('n', keys.step_into, dap.step_into, { desc = ' Step into' })
vim.keymap.set('n', keys.step_over, dap.step_over, { desc = ' Step over' })
vim.keymap.set('n', keys.step_out, dap.step_out, { desc = ' Step out' })
vim.keymap.set('n', keys.dap_close, dap.close, { desc = 'DAP: Close session' })
vim.keymap.set('n', keys.dap_terminate, dap.terminate, { desc = ' Terminate session' })
vim.keymap.set('n', keys.dap_restart, dap.restart_frame, { desc = 'DAP: Restart' })
-- vim.keymap.set('n', '<F5>', dap.restart_frame, { desc = 'DAP: Restart' })

-- vim.keymap.set('n', '<leader>dc', dap.run_to_cursor, { desc = 'DAP: Run to Cursor' })
vim.keymap.set('n', keys.dap_repl_toggle, dap.repl.toggle, { desc = 'DAP: Toggle REPL' })
vim.keymap.set('n', keys.dap_hover, require('dap.ui.widgets').hover, { desc = 'DAP: Hover' })


-- vim.keymap.set('n', keys.log_breakpoints, function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', keys.toggle_breakpoint, dap.toggle_breakpoint, { desc = 'DAP: Breakpoint' })
vim.keymap.set('n', keys.set_breakpoint, function()
  local input = vim.fn.input 'Condition for breakpoint:'
  dap.set_breakpoint(input)
end, { desc = 'DAP: Conditional Breakpoint' })
vim.keymap.set('n', keys.clear_breakpoints, dap.clear_breakpoints, { desc = 'DAP: Clear Breakpoints' })
