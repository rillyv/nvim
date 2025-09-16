return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		local ui = require("dapui")

		ui.setup()

		dap.adapters.php = {
			type = "executable",
			command = "node",
			args = { os.getenv("HOME") .. "/vscode-php-debug/out/phpDebug.js" },
		}

		dap.configurations.php = {
			{
				type = "php",
				request = "launch",
				name = "Listen for Xdebug",
				port = 9003,
			},
		}

		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
		vim.keymap.set("n", "<leader>B", dap.clear_breakpoints, { desc = "Clear all breakpoints" })
		vim.keymap.set("n", "<leader>bc", function()
			dap.set_breakpoint(vim.fn.input("Condition: "))
		end, { desc = "Conditional breakpoint" })
		vim.keymap.set("n", "<leader>bl", function()
			dap.set_breakpoint(nil, nil, vim.fn.input("Log message: "))
		end, { desc = "Log point" })
		vim.keymap.set("n", "<leader>dc", dap.run_to_cursor, { desc = "Run to cursor" })
		vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run last" })
		vim.keymap.set("n", "<leader>du", ui.toggle, { desc = "Toggle DAP UI" })

		vim.keymap.set("n", "<leader>?", function()
			local expr = vim.fn.expand("<cexpr>")
			if expr == "" then
				expr = vim.fn.input("Expr: ")
			end
			require("dapui").eval(expr, { enter = true })
		end, { desc = "DAP eval" })

		vim.keymap.set("n", "<F1>", dap.continue)
		vim.keymap.set("n", "<F2>", dap.step_into)
		vim.keymap.set("n", "<F3>", dap.step_over)
		vim.keymap.set("n", "<F4>", dap.step_out)
		vim.keymap.set("n", "<F5>", dap.step_back)
		vim.keymap.set("n", "<F12>", dap.restart)

		dap.listeners.before.attach.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			ui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			ui.close()
		end
	end,
}
