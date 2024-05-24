return {
	{	
		"nvim-telescope/telescope.nvim",
		dependencies = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
		config = function()
			require("telescope").setup({})

			local option = { noremap = true, silent = true }

			local keys = require("custom_keys")
			local builtin = require("telescope.builtin")
			option.desc = "[S]earch [F]ile"
			vim.keymap.set("n", keys.find_files, builtin.find_files, option)
			option.desc = "[S]earch by [G]rep"
			vim.keymap.set("n", keys.live_grep, builtin.live_grep, option)
			option.desc = "[S]earch current [W]ord"
			vim.keymap.set("n", keys.search_cursor, builtin.grep_string, option)
			option.desc = "[ ]Find existing buffers"
			vim.keymap.set("n", keys.find_buffer, builtin.buffers, option)
			option.desc = "[S]earch [K]eymaps"
			vim.keymap.set("n", keys.keymaps, builtin.keymaps, option)
		end,
	},
}
