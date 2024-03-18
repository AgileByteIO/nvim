return {
	{
		"mxsdev/nvim-dap-vscode-js",
		dependencies = {
			{
				"microsoft/vscode-js-debug",
				-- This seems not to work. build manual in ~/.local/share/folder
				build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
			},
		},
		config = function()
			require("dap-vscode-js").setup({
				-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
				debugger_path = vim.fn.stdpath("data") .."/lazy/vscode-js-debug", -- Path to vscode-js-debug
				-- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
				-- debugger_cmd = { "js-debug-adapter" },
				adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
				-- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
				-- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
				-- log_console_level = vim.log.levels.ERROR -- Logging level for output to console.
			})
		end,
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
		},
		config = function()
			require("dapui").setup()

			local dap = require("dap")
			local dapui = require("dapui")

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			for _, language in ipairs({ "typescript", "javascript" }) do
				dap.configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}",
						sourceMaps = true,
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach",
            address = "127.0.0.1",
            port = 9230,
						processId = require("dap.utils").pick_process,
            skipFiles = { "<node_internals>/**", "node_modules/**" },
						cwd = "${workspaceFolder}",
						sourceMaps = true,
					},
					{
						name = "Next.js debug server-side",
						type = "node-terminal",
						request = "launch",
						command = "npm run dev",
            cwd = "${workspaceFolder}",
						sourceMaps = true,
					},
					{
						name = "Next.js: debug client-side",
						type = "pwa-chrome",
						request = "launch",
						url = "http://localhost:3000",
					},
					{
						name = "Next.js debug full stack",
						type = "node-terminal",
						request = "launch",
						command = "npm run dev",
						serverReadyAction = {
							pattern = "- Local:.+(https?://.+)",
							uriFormat = "%s",
							action = "debugWithChrome",
						},
					},
				}
			end

			vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {})
			vim.keymap.set("n", "<leader>dc", dap.continue, {})
		end,
	},
}
