return {
	"nvimtools/none-ls.nvim",
	config = function()
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		local null_ls = require("null-ls")
		local helpers = require("null-ls.helpers")
		local methods = require("null-ls.methods")
		local tofu_fmt = helpers.make_builtin({
			name = "tofu_fmt",
			method = methods.internal.FORMATTING,
			filetypes = { "terraform", "terraform-vars" },
			generator_opts = {
				command = "tofu",
				args = { "fmt", "-" },
				to_stdin = true,
			},
			factory = helpers.formatter_factory,
		})
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.isort,
				null_ls.builtins.formatting.prettier,
				tofu_fmt,
				null_ls.builtins.diagnostics.eslint_d,
				null_ls.builtins.diagnostics.codespell,
				null_ls.builtins.diagnostics.tflint,
				-- null_ls.builtins.completion.spell,
			},
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					local filetype = vim.bo[bufnr].filetype
					if filetype == "terraform" or filetype == "terraform-vars" then
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ async = false })
							end,
						})
					end
				end
			end,
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
