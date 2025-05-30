return{
     -- 安装 nvim-dap 及其 UI 插件
    {
        'mfussenegger/nvim-dap',
        lazy = true,
        config = function()
            require 'config.debugger'
        end,
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'mfussenegger/nvim-dap', 'theHamsta/nvim-dap-virtual-text', 'nvim-neotest/nvim-nio' },
        config = function()
            require('nvim-dap-virtual-text').setup({}) -- optional
            require 'config.dapUI'
        end,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
  dependencies = "mason.nvim",
  cmd = { "DapInstall", "DapUninstall" },
  opts = {
    -- Makes a best effort to setup the various debuggers with
    -- reasonable debug configurations
    automatic_installation = true,

    -- You can provide additional configuration to the handlers,
    -- see mason-nvim-dap README for more information
    handlers = {},

    -- You'll need to check that you have the required things installed
    -- online, please don't ask me how to install them :)
    ensure_installed = {
                "js",
      -- Update this to ensure that you have the debuggers for the langs you want
    },
  },
}
}
