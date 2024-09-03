local keys = require("custom_keys")
local opts = require("custom_opts")
local pjtCfgs = require("other.projectInit")

-- Setup keymapping
local function set_keymap()
	local map = vim.keymap.set
	local option = { noremap = true, silent = true }

	map("n", keys.jump_left_window, "<C-W>h", option)
	map("n", keys.jump_down_window, "<C-W>j", option)
	map("n", keys.jump_up_window, "<C-W>k", option)
	map("n", keys.jump_right_window, "<C-W>l", option)

	option.desc = "向下拆分窗口"
	map("n", keys.split_down_window, ":split<CR>", option)
	option.desc = "向左拆分窗口"
	map("n", keys.split_right_window, ":vsplit<CR>", option)
	option.desc = "关闭当前窗口"
	map("n", keys.colse_window, ":confirm q<CR>", option)

	vim.cmd([[
    " press esc to cancel search highlight
    nnoremap <silent> <Esc> :nohlsearch<CR>:echo<CR>
	]])

	-- for markdown file
	vim.cmd([[
    " optimized up and down move when set wrap for markdown file
    autocmd FileType markdown noremap <buffer> j gj
    autocmd FileType markdown noremap <buffer> k gk
	autocmd FileType markdown setlocal wrap
	]])

	-- Supported by bufdelete
	vim.cmd([[
	cnoreabbrev bdelete Bdelete
	cnoreabbrev bdelete! Bdelete!
	cnoreabbrev bwipeout Bwipeout
	cnoreabbrev bwipeout! Bwipeout!
	]])

	-- Supported by bufferline
	option.desc = "切换至Buffline"
	map("n", keys.pick_tab, ":BufferLinePick<CR>", option)
	option.desc = "关闭当前Buffline"
	map("n", keys.closeBuffer, ":Bdelete!<CR>", option)
	option.desc = nil
	map("n", keys.pickBuffer1, "<Cmd>BufferLineGoToBuffer 1<CR>", option)
	map("n", keys.pickBuffer2, "<Cmd>BufferLineGoToBuffer 2<CR>", option)
	map("n", keys.pickBuffer3, "<Cmd>BufferLineGoToBuffer 3<CR>", option)
	map("n", keys.pickBuffer4, "<Cmd>BufferLineGoToBuffer 4<CR>", option)
	map("n", keys.pickBuffer5, "<Cmd>BufferLineGoToBuffer 5<CR>", option)
	map("n", keys.pickBuffer6, "<Cmd>BufferLineGoToBuffer 6<CR>", option)
	map("n", keys.pickBuffer7, "<Cmd>BufferLineGoToBuffer 7<CR>", option)
	map("n", keys.pickBuffer8, "<Cmd>BufferLineGoToBuffer 8<CR>", option)
	map("n", keys.pickBuffer9, "<Cmd>BufferLineGoToBuffer 9<CR>", option)

	-- Supported by nvim-tree
	map("n", keys.file_explorer, ":Neotree position=left source=filesystem action=show toggle=true<CR>", option)
	map("n", keys.git_status, ":Neotree position=float source=git_status action=show toggle=true<CR>", option)

	-- Supported by aerial
	map("n", keys.outline, ":AerialToggle! right<CR>", option)

	-- Supported by diffview
	map("n", keys.diff_open, ":DiffviewOpen<CR>", option)
	map("n", keys.diff_close, ":DiffviewClose<CR>", option)

	-- Supported by toggleterm
	-- float terminal
	local float_terminal_default = require("toggleterm.terminal").Terminal:new({
		direction = "float",
		on_open = function(term)
			-- forced to change the working dir for terminal
			-- This will solve the problem of not updating the directory when switching sessions.
			local cwd = vim.fn.getcwd()
			if cwd ~= term.dir then
				term:change_dir(cwd)
			end
			-- when float term opened, disable bottom terminal
			vim.api.nvim_del_keymap("t", keys.terminal_bottom)
			vim.cmd("startinsert!")
		end,
		on_close = function(t, job, exit_code, name)
			-- when float term closed, enable bottom terminal
			map("t", keys.terminal_bottom, "<C-\\><C-n>:lua _bottom_term_toggle()<CR>", option)
		end,
	})
	function _float_term_toggle()
		float_terminal_default:toggle()
	end

	-- bottom terminal
	local bottom_terminal_default = require("toggleterm.terminal").Terminal:new({
		direction = "horizontal",
		on_open = function(term)
			-- forced to change the working dir for terminal
			-- This will solve the problem of not updating the directory when switching sessions.
			local cwd = vim.fn.getcwd()
			if cwd ~= term.dir then
				term:change_dir(cwd)
			end

			-- set keymapping
			local opts = { buffer = 0 }
			vim.api.nvim_buf_set_keymap(
				term.bufnr,
				"t",
				"<C-h>",
				[[<Cmd>wincmd h<CR>]],
				{ noremap = true, silent = true }
			)
			vim.api.nvim_buf_set_keymap(
				term.bufnr,
				"t",
				"<C-j>",
				[[<Cmd>wincmd j<CR>]],
				{ noremap = true, silent = true }
			)
			vim.api.nvim_buf_set_keymap(
				term.bufnr,
				"t",
				"<C-k>",
				[[<Cmd>wincmd k<CR>]],
				{ noremap = true, silent = true }
			)
			vim.api.nvim_buf_set_keymap(
				term.bufnr,
				"t",
				"<C-l>",
				[[<Cmd>wincmd l<CR>]],
				{ noremap = true, silent = true }
			)
			vim.cmd("startinsert!")
		end,
		on_exit = function(t, job, exit_code, name)
			vim.cmd("quit!")
		end,
	})
	function _bottom_term_toggle()
		bottom_terminal_default:toggle()
	end

	map("n", keys.terminal_float, ":lua _float_term_toggle()<CR>", option)
	map("t", keys.terminal_float, "<C-\\><C-n>:lua _float_term_toggle()<CR>", option)
	map("n", keys.terminal_bottom, ":lua _bottom_term_toggle()<CR>", option)
	map("t", keys.terminal_bottom, "<C-\\><C-n>:lua _bottom_term_toggle()<CR>", option)

	vim.cmd([[
    command! Termfloat :lua _float_term_toggle()
    ]])
	vim.cmd([[cnoreabbrev terminal Termfloat]])

	-- Supported by nvim-session-manager
	map("n", keys.switch_session, ":SessionManager load_session<CR>", option)
end

-- Set up transparency
local function set_transparency()
	local transparency = opts.window_transparency
	-- Setup global transparency for float window.
	vim.api.nvim_command(string.format("autocmd FileType * set winblend=%d", transparency))
	-- Setup global transparency for popup menu.
	vim.o.pumblend = transparency
end

-- Set up auto command
local function set_autocmd()
	vim.api.nvim_create_autocmd("TextYankPost", {
		desc = "Highlight when yanking (copying) text",
		group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
		callback = function()
			vim.highlight.on_yank()
		end,
	})

	if opts.auto_save then
		vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
			pattern = { "*" },
			command = "silent! wall",
			nested = true,
		})
	end

	vim.api.nvim_create_autocmd({ "BufEnter" }, {
		pattern = "*",
		callback = function()
			vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
		end,
	})
end

local function set_user_command()
	vim.api.nvim_create_user_command('PtcInit', pjtCfgs.prettierrc_init_project, {})
end

local function allow_CV_in_neovim()
	vim.api.nvim_set_keymap('', '<C-v>', '+p<CR>', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('!', '<C-v>', '<C-R>+', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('t', '<C-v>', '<C-R>+', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('v', '<C-v>', '<C-R>+', { noremap = true, silent = true })
end
set_keymap()
set_transparency()
set_autocmd()
set_user_command()
allow_CV_in_neovim()
