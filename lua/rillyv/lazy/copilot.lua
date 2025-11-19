vim.g.copilot_enabled = 0

return {
	"github/copilot.vim",
    config = function()
        vim.keymap.set("n", "<leader>cpe", ":Copilot enable<CR>", { noremap = true, silent = true, desc = "Enable Copilot" })
        vim.keymap.set("n", "<leader>cpd", ":Copilot disable<CR>", { noremap = true, silent = true, desc = "Disable Copilot" })
    end,
}
