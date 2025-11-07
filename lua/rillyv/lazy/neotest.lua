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
      vim.keymap.set("n", "<leader>top", "<cmd>lua require('neotest').output_panel.toggle()<CR>"); -- Toggle output panel
      vim.keymap.set("n", "<leader>trn", "<cmd>lua require('neotest').run.run()<CR>"); -- Run nearest test
      vim.keymap.set("n", "<leader>ts", "<cmd>lua require('neotest').run.stop()<CR>"); -- Stop test
      vim.keymap.set("n", "<leader>tcf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>"); -- Run current file
      vim.keymap.set("n", "<leader>tra", "<cmd>lua require('neotest').run.run({ suite = true })<cr>"); -- Run all tests
      vim.keymap.set("n", "<leader>tdn", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>"); -- Debug nearest test
      vim.keymap.set("n", "<leader>tan", "<cmd>lua require('neotest').run.attach()<cr>"); -- Attach to nearest test
      vim.keymap.set("n", "<leader>tso", "<cmd>lua require('neotest').output.open()<cr>"); -- Show test output
      vim.keymap.set("n", "<leader>tsu", "<cmd>lua require('neotest').summary.toggle()<cr>"); -- Toggle summary
      vim.keymap.set("n", "<leader>tci", "<cmd>lua require('neotest').run.run({ suite = true, env = { CI = true } })<cr>"); -- Run all tests with CI

      output_panel = {
          open = 'botright vsplit | vertical resize 80'
      },
      adapters = {
        require("neotest-phpunit")
      },
    })
  end
}
