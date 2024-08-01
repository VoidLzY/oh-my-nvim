return {
	-- Syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				indent = {
					enable = true,
					disable = {},
				},
				ensure_installed = { "markdown", "markdown_inline", "regex" },
				sync_install = false,
				auto_install = true,
				ignore_install = {},

				highlight = {
					enable = true,
					disable = {},
					disable = function(lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
					additional_vim_regex_highlighting = false,
				},

				fold = {
					enable = true,
				},
			})
			require("nvim-treesitter.configs").setup({
				highlight = {
					enable = true,
					-- additional_vim_regex_highlighting = true, -- DO NOT SET THIS
				},
			})
			-- let it to use 'markdown' parser for mdx filetype.
			vim.treesitter.language.register("markdown", "mdx")
		end,
	},

	-- Colors highlighting
	{
		"NvChad/nvim-colorizer.lua",
		config = function(plun)
			require("colorizer").setup({
				user_default_options = {
					names = false,
				},
			})
		end,
	},

	-- Spell Check
	{
		"ravibrock/spellwarn.nvim",
		event = "VeryLazy",
		-- config = true,
		config = function()
			require("spellwarn").setup({
				event = { -- event(s) to refresh diagnostics on
					"CursorHold",
					"TextChanged",
					"TextChangedI",
					"TextChangedP",
					"TextChangedT",
				},
				ft_config = { -- filetypes to override ft_default for
					alpha   = false,
					help    = false,
					lazy    = false,
					lspinfo = false,
					mason   = false,
				},
				ft_default = true, -- whether to enable or disable for all filetypes by default
				max_file_size = nil, -- maximum file size to check in lines (nil for no limit)
				severity = { -- severity for each spelling error type (false to disable)
					spellbad   = "WARN",
					spellcap   = "HINT",
					spelllocal = "HINT",
					spellrare  = "INFO",
				},
				prefix = "possible misspelling(s): ", -- prefix for each diagnostic message
			})
		end
	}
}
