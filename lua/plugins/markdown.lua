-- ===
-- === Markdown 渲染，打开 md 文件直接在 buffer 里显示排版效果
-- ===
return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		ft = "markdown",
		opts = {
			file_types = { "markdown" },
		},
	},
}
