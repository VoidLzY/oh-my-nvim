return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { 'folke/neodev.nvim', opts = {} },
    },
		config = function()
			require("plugins/lspconfig/config")()
		end,
	},
	-- {
	-- 	"williamboman/mason.nvim",
	-- 	config = function()
	-- 		require("mason").setup({
	-- 			ui = {
	-- 				icons = {
	-- 					package_installed = "✓",
	-- 					package_pending = "➜",
	-- 					package_uninstalled = "✗",
	-- 				},
	-- 				border = "rounded",
	-- 			},
	-- 		})
	-- 	end,
	-- },
	--
	-- {
	-- 	"williamboman/mason-lspconfig.nvim",
	-- 	config = function()
	-- 	local capabilities = vim.lsp.protocol.make_client_capabilities()
	-- 	capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
	-- 
	-- 	local servers = {
 --        -- clangd = {},
 --        -- gopls = {},
 --        -- pyright = {},
 --        -- rust_analyzer = {},
 --        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
 --        --
 --        -- Some languages (like typescript) have entire language plugins that can be useful:
 --        --    https://github.com/pmizio/typescript-tools.nvim
 --        --
 --        -- But for many setups, the LSP (`tsserver`) will work just fine
 --        tsserver = {
 --          'pmizio/typescript-tools.nvim',
 --          dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
 --          opts = {},
 --        },
 --        --
	--
 --        lua_ls = {
 --          -- cmd = {...},
 --          -- filetypes = { ...},
 --          -- capabilities = {},
 --          settings = {
 --            Lua = {
 --              completion = {
 --                callSnippet = 'Replace',
 --              },
 --              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
 --              -- diagnostics = { disable = { 'missing-fields' } },
 --            },
 --          },
 --        },
 --      }
	--  local ensure_installed = vim.tbl_keys(servers or {})
 --      vim.list_extend(ensure_installed, {
 --        'stylua', -- Used to format Lua code
 --      })
	--
	-- 		 require('mason-tool-installer').setup { ensure_installed = ensure_installed }
	-- 		require("mason-lspconfig").setup()
	-- 		require("mason-lspconfig").setup_handlers({
	-- 			-- The first entry (without a key) will be the default handler
	-- 			-- and will be called for each installed server that doesn't have
	-- 			-- a dedicated handler.
	-- 			function(server_name) -- default handler (optional)
	-- 			local server = servers[server_name] or {}
	-- 		    server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
	-- 				require("lspconfig")[server_name].setup({})
	-- 			end,
	-- 			-- Next, you can provide a dedicated handler for specific servers.
	-- 			-- For example, a handler override for the `rust_analyzer`:
	-- 			 ["rust_analyzer"] = function ()
	-- 			     require("rust-tools").setup {}
	-- 			 end,
	-- 		})
	-- 	end,
	-- },
	--
		{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local null_ls = require("null-ls")
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			null_ls.setup({
				border = "rounded",
				cmd = { "nvim" },
				debounce = 250,
				debug = false,
				default_timeout = 5000,
				diagnostic_config = {},
				diagnostics_format = "#{m}",
				fallback_severity = vim.diagnostic.severity.ERROR,
				log_level = "warn",
				notify_format = "[null-ls] %s",
				on_init = nil,
				on_exit = nil,
				root_dir = require("null-ls.utils").root_pattern(".null-ls-root", "Makefile", ".git"),
				should_attach = nil,
				sources = nil,
				temp_dir = nil,
				update_in_insert = false,
				-- formatting on save
				--on_attach = function(client, bufnr)
				--	if client.supports_method("textDocument/formatting") then
				--		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				--		vim.api.nvim_create_autocmd("BufWritePre", {
				--			group = augroup,
				--			buffer = bufnr,
				--			callback = function()
				--				vim.lsp.buf.format({ bufnr = bufnr })
				--			end,
				--		})
				--	end
				--end,
			}) -- end of setup
		end,
	},

	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		config = function()
			require("mason-null-ls").setup({
				automatic_setup = true,
				ensure_installed = { "shfmt", "prettier", "stylua","eslint_d"},
				handlers = {},
			})
		end,
	},
	 {
    'MunifTanjim/prettier.nvim',
    config = function()
      require('prettier').setup({
        bin = 'prettier', -- 或者你可以指定 prettier 的绝对路径
        filetypes = {
          "css",
          "graphql",
          "html",
          "javascript",
          "javascriptreact",
          "json",
          "less",
          "markdown",
          "scss",
          "typescript",
          "typescriptreact",
          "yaml",
        },
        -- 可以添加其他 prettier 的配置选项
      })
    end,
  },
}
