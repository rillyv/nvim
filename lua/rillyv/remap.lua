vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", "<cmd>Oil<CR>")
vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>", { silent = true })

-- Delete without yanking (black hole register)
vim.keymap.set({"n", "v"}, "<leader>x", '"_x')
vim.keymap.set("n", "<leader>D", '"_D')
vim.keymap.set({"n", "v"}, "<leader>d", '"_d')
vim.keymap.set("n", "<leader>dd", '"_dd')
vim.keymap.set("n", "<leader>c", '"_c')
vim.keymap.set("n", "<leader>C", '"_C')
vim.keymap.set("n", "<leader>ci", '"_ci')
vim.keymap.set("n", "<leader>ca", '"_ca')
vim.keymap.set({"n", "v"}, "<leader>s", '"_s')

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "<leader>f", function()
	require("conform").format()
end, { desc = "Format with Conform with LSP fallback." })

vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>cc", function()
	if vim.fn.getqflist({ winid = 1 }).winid ~= 0 then
		vim.cmd("cclose")
	else
		vim.cmd("copen")
	end
end)

vim.g.session_root = vim.fn.getcwd()
vim.keymap.set("n", "<leader>cw", function()
	local root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
	local file = vim.fn.expand("%:p")
	local rel = vim.fn.fnamemodify(file, ":." .. root)
	vim.fn.setreg("+", rel)
end)
