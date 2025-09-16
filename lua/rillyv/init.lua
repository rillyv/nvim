require("rillyv.set")
require("rillyv.remap")
require("rillyv.lazy_init")

local augroup = vim.api.nvim_create_augroup
local RillyvGroup = augroup("rillyv", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

function R(name)
	require("plenary.reload").reload_module(name)
end

vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.hl.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

autocmd("VimEnter", {
	group = RillyvGroup,
	callback = function()
		ColorMyPencils()
	end,
})

autocmd("LspAttach", {
	group = RillyvGroup,
	callback = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set("n", "gd", function()
			require("telescope.builtin").lsp_definitions()
		end, opts)
		vim.keymap.set("n", "gD", function()
			vim.lsp.buf.definition()
		end, opts)

		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)

		vim.keymap.set("n", "<leader>vca", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "<leader>vim", function()
			require("telescope.builtin").lsp_implementations()
		end, opts)
		vim.keymap.set("n", "<leader>vrn", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("n", "<leader>vrr", function()
			require("telescope.builtin").lsp_references()
		end, opts)
		vim.keymap.set("n", "<leader>vtd", function()
			require("telescope.builtin").lsp_type_definitions()
		end, opts)
		vim.keymap.set("n", "<leader>vds", function()
			require("telescope.builtin").lsp_document_symbols()
		end, opts)
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, opts)

		vim.keymap.set("n", "<leader>vws", function()
			require("telescope.builtin").lsp_workspace_symbols()
		end, opts)
		vim.keymap.set("n", "<leader>vd", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_next()
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_prev()
		end, opts)

		vim.keymap.set("n", "<leader>vlr", "<cmd>LspRestart<cr>", { desc = "Restart LSP" })
	end,
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
