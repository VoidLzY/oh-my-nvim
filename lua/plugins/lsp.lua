return {
	--LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP.
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", opts = {} },

			-- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
			-- used for completion, annotations and signatures of Neovim apis
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			require("plugins/lspconfig/config")()
		end,
	},
	--Format
	-- {
	-- 	"jose-elias-alvarez/null-ls.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim" },
	-- 	config = function()
	-- 		local null_ls = require("null-ls")
	-- 		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
	--
	-- 		null_ls.setup({
	-- 			border = "rounded",
	-- 			cmd = { "nvim" },
	-- 			debounce = 250,
	-- 			debug = false,
	-- 			default_timeout = 5000,
	-- 			diagnostic_config = {},
	-- 			diagnostics_format = "#{m}",
	-- 			fallback_severity = vim.diagnostic.severity.ERROR,
	-- 			log_level = "warn",
	-- 			notify_format = "[null-ls] %s",
	-- 			on_init = nil,
	-- 			on_exit = nil,
	-- 			root_dir = require("null-ls.utils").root_pattern(".null-ls-root", "Makefile", ".git"),
	-- 			should_attach = nil,
	-- 			sources = nil,
	-- 			temp_dir = nil,
	-- 			update_in_insert = false,
	-- 			-- formatting on save
	-- 			--on_attach = function(client, bufnr)
	-- 			--	if client.supports_method("textDocument/formatting") then
	-- 			--		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
	-- 			--		vim.api.nvim_create_autocmd("BufWritePre", {
	-- 			--			group = augroup,
	-- 			--			buffer = bufnr,
	-- 			--			callback = function()
	-- 			--				vim.lsp.buf.format({ bufnr = bufnr })
	-- 			--			end,
	-- 			--		})
	-- 			--	end
	-- 			--end,
	-- 		}) -- end of setup
	-- 	end,
	-- },

	-- {
	-- 	"MunifTanjim/prettier.nvim",
	-- 	config = function()
	-- 		require("prettier").setup({
	-- 			bin = "prettier", -- 或者你可以指定 prettier 的绝对路径
	-- 			filetypes = {
	-- 				"css",
	-- 				"graphql",
	-- 				"html",
	-- 				"javascript",
	-- 				"javascriptreact",
	-- 				"json",
	-- 				"less",
	-- 				"markdown",
	-- 				"scss",
	-- 				"typescript",
	-- 				"typescriptreact",
	-- 				"yaml",
	-- 				"rust"
	-- 			},
	-- 			-- 可以添加其他 prettier 的配置选项
	-- 		})
	-- 	end,
	-- },

	{
		"mhartington/formatter.nvim",
		config = function()
			local ft_names = {
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact"
			}
			local filetype = {}
			for _, ft_name in ipairs(ft_names) do
				filetype[ft_name] = {
					--上述filetype，都直接对应目录下的prettier
					require("formatter.filetypes." .. ft_name).prettier
				}
			end
			require('formatter').setup({
				filetype = filetype
			})
			--keymap设置
			local keymap = vim.keymap.set
			local opts = { noremap = true }
			keymap("n", "<leader>f", "<cmd>Format<CR>", opts)
			keymap("n", "<leader>F", "<cmd>Formatwrite<CR>", opts)
		end
	}
}
