-- ===
-- === 代码高亮
-- ===
return {
	-- Syntax highlighting
	-- nvim-treesitter master 分支不支持 nvim>=0.12，已迁移到 main 分支的新 API
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			-- 安装缺失的 parser（幂等，已装的会跳过）
			require("nvim-treesitter").install({ "markdown", "markdown_inline" })

			-- 对所有已安装 parser 的文件类型启用高亮，大文件（>100KB）跳过
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "*",
				callback = function(args)
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(args.buf))
					if ok and stats and stats.size > 100 * 1024 then
						return
					end
					pcall(vim.treesitter.start, args.buf)
				end,
			})
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

	
}
