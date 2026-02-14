local map = vim.keymap.set

-- General
vim.o.syntax = "off"
vim.o.number = true            -- Show line numbers
vim.o.relativenumber = true    -- Make line numbers relative to currentline
vim.o.swapfile = false         -- Don't create .swp files on disk, I'm fine with losing unsaved stuff
vim.o.mouse = "n"              -- Only in normal mode
vim.o.ignorecase = true        -- Ignore case in search
vim.o.smartcase = true         -- ...unless at least one uppercase letter is used
vim.o.conceallevel = 2         -- Conceal characters on other lines
vim.o.undofile = true          -- Persistent undo history, saved in the following dir:
vim.o.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
vim.o.scrolloff = 8            -- Start scrolling the buffer when cursor is this many lines away from top/bottom
vim.o.signcolumn = "yes"       -- Always show signcolumn to avoid the buffer shifting around horizontally
vim.o.cursorline = true        -- Highlight the current line
vim.o.cursorlineopt = "number" -- ...but only the number, not its contents
vim.o.winborder = "rounded"    -- Give pop-ups rounded borders

-- Tab size, and make tabs into spaces
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- Set the leader key to space
vim.g.mapleader = " "

-- Hook into package manager events
local plugins_changed = function(ev)
	local name, kind = ev.data.spec.name, ev.data.kind
	-- Build Blink's fuzzy matcher on install/update.
	if name == "blink.cmp" and (kind == "install" or kind == "update") then
		local res = vim.system({ "cargo", "build", "--release" }, { cwd = ev.data.path }):wait()
		if res.code == 0 then
			vim.notify("Building blink.cmp done", vim.log.levels.INFO)
		else
			vim.notify("Building blink.cmp failed", vim.log.levels.ERROR)
		end
	end
end
vim.api.nvim_create_autocmd("PackChanged", { callback = plugins_changed })

-- Add the plugins
local gh = function(repo) return "https://github.com/" .. repo end
vim.pack.add({
	-- Basic, no-config utilities
	{ src = gh("tpope/vim-surround") }, -- Surround text objects with things (parens, quotes etc.)
	{ src = gh("tpope/vim-repeat") }, -- Extend the . command to things like vim-surround
	{ src = gh("tpope/vim-sleuth") }, -- Automatically set tab width/spaces
	{ src = gh("romainl/vim-cool") }, -- No more lingering hl after search
	{ src = gh("mbbill/undotree") }, -- Visualise the vim undo tree
	{ src = gh("ibhagwan/fzf-lua") }, -- Fuzzy finder for files etc.

	-- Visual stuff
	{ src = gh("nvim-lualine/lualine.nvim") },
	{ src = gh("SmiteshP/nvim-navic") },
	{ src = gh("SmiteshP/nvim-navbuddy") },
	{ src = gh("MunifTanjim/nui.nvim") },
	{ src = gh("akinsho/bufferline.nvim") },
	{ src = gh("lukas-reineke/indent-blankline.nvim") }, -- Indent prettifyer
	{ src = gh("ellisonleao/gruvbox.nvim") },         -- Theme :)
	{ src = gh("lewis6991/gitsigns.nvim") },          -- Git integration

	-- Proper language parsers
	{ src = gh("nvim-treesitter/nvim-treesitter") },
	{ src = gh("nvim-treesitter/nvim-treesitter-textobjects") },

	-- Autocompletion
	{ src = gh("saghen/blink.cmp") },
})

-- Autocompletion
require("blink.cmp").setup({
	-- Auto-select the first item but don't insert it until explicitly accepted
	completion = { list = { selection = { preselect = true, auto_insert = false } } },
	signature = { enabled = true },
	keymap = {
		-- Accept using enter
		['<CR>'] = { 'accept', 'fallback' },
		-- Tab navigates completion results unless we're in a snippet.
		['<Tab>'] = {
			function(cmp)
				if cmp.snippet_active() then
					return cmp.snippet_forward()
				else
					return cmp.select_next()
				end
			end,
			'snippet_forward',
			'fallback'
		},
		['<S-Tab>'] = {
			function(cmp)
				if cmp.snippet_active() then
					return cmp.snippet_backward()
				else
					return cmp.select_prev()
				end
			end,
			'snippet_backward',
			'fallback'
		},
	}
})

-- LSP
vim.lsp.enable({ "lua_ls", "ruff", "pyright" })

-- What to run when an LSP attaches to a buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		map('n', '<space>e', vim.diagnostic.open_float)
		map("n", "<leader>f", vim.lsp.buf.format)
		map("n", "<leader>r", vim.lsp.buf.rename)
		map("n", "gd", vim.lsp.buf.definition)

		-- If the LSP provides inline hints, enable them.
		if vim.lsp.get_client_by_id(ev.data.client_id).server_capabilities.inlayHintProvider then
			vim.lsp.inlay_hint.enable(true)
		end
	end
})

-- Keymaps
-- Move lines up/down in visual mode
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

-- Easy undotree access
map('n', '<leader>u', vim.cmd.UndotreeToggle)

-- Fuzzy finder
require("fzf-lua")
map("n", "<leader>sf", FzfLua.files)
map("n", "<leader>sg", FzfLua.live_grep)
map("n", "<leader>sr", FzfLua.resume)

-- Make current file executable (for scripts etc)
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- [F]ix last spelling mistake and move back to current position.
map('n', '<C-f>', function()
	if vim.opt.spell then
		-- Set a mark ([s]pell), jump to last spell error, fix w/ first suggestion and
		-- jump back to mark (same cursor pos (`), not just line ('))
		return "ms[s1z=`s"
	else
		return ""
	end
end, { expr = true, replace_keycodes = true })

-- Diagnostics
-- Much of this is taken from TJ DeVries' dotfiles.
vim.diagnostic.config {
	underline = true,
	virtual_text = {
		severity = nil,
		source = "if_many",
		format = nil,
	},

	-- Colour line numbers instead of using statuscolumn for LSP diagnostics.
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = '',
			[vim.diagnostic.severity.WARN] = '',
			[vim.diagnostic.severity.INFO] = '',
			[vim.diagnostic.severity.HINT] = '',
		},
		numhl = {
			[vim.diagnostic.severity.WARN] = 'WarningMsg',
			[vim.diagnostic.severity.ERROR] = 'ErrorMsg',
			[vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
			[vim.diagnostic.severity.HINT] = 'DiagnosticHint',
		},
	},

	-- options for floating windows:
	float = {
		show_header = true,
		border = "rounded",
		-- source = "always",
		format = function(d)
			if not d.code and not d.user_data then
				return d.message
			end

			local t = vim.deepcopy(d)
			local code = d.code
			if not code then
				if not d.user_data.lsp then
					return d.message
				end

				code = d.user_data.lsp.code
			end
			if code then
				t.message = string.format("%s [%s]", t.message, code):gsub("1. ", "")
			end
			return t.message
		end,
	},

	-- Display more severe errors first
	severity_sort = true,
}
