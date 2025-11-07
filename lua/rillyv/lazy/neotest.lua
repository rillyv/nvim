return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "olimorris/neotest-phpunit"
  },
  config = function()
    require("neotest").setup({
      vim.keymap.set("n", "<leader>top", "<cmd>:Neotest output-panel<CR>");
      vim.keymap.set("n", "<leader>trn", "<cmd>lua require(\"neotest\").run.run()<CR>");
      vim.keymap.set("n", "<leader>tsn", "<cmd>lua require(\"neotest\").run.stop()<CR>");
      vim.keymap.set("n", "<leader>tcf", "<cmd>lua require(\"neotest\").run.run(vim.fn.expand(\"%\"))<CR>");

      adapters = {
        require("neotest-phpunit")
      },
    })
  end
}
