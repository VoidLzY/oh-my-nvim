return {
	-- ===
	-- ===底部状态栏===
	-- ===
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
		config = function()
			require("plugins/lualine/config")()
		end,
	},


	-- Outline
    -- ===
    -- === 代码结构侧边栏插件,F7激活
    -- ===
	{
		"stevearc/aerial.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("aerial").setup({
				lazy_load = false,
				open_automatic = require("custom_opts").auto_open_outline,
				manage_folds = true,
				link_folds_to_tree = true,
				link_tree_to_folds = true,
				autojump = true,
			})
		end,
	},

	-- ===
	-- ===顶部标签页===
	-- ===
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("plugins/bufferline/config")()
		end,
	},

	-- Improve the ui
	{
		"stevearc/dressing.nvim",
		opts = {},
	},
}
