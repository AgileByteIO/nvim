return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"rshkarin/mason-nvim-lint",
		dependencies = {
			"mfussenegger/nvim-lint",
		},
		config = function()
			require("mason-nvim-lint").setup({
				automatic_installation = true,
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		config = function()
				require("mason-lspconfig").setup({
					ensure_installed = {
						"lua_ls",
						"tsserver",
						"tailwindcss",
						"pyright",
						"sqlls",
						"terraformls",
					},
				})
			end,
		},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			vim.lsp.config.pyright = {
				capabilities = capabilities,
				filetypes = { "sh", "python" },
			}
			vim.lsp.config.lua_ls = {
				capabilities = capabilities,
			}
			vim.lsp.config.tsserver = {
				capabilities = capabilities,
			}
			vim.lsp.config.tailwindcss = {
				capabilities = capabilities,
			}
			vim.lsp.config.sqlls = {
				capabilities = capabilities,
			}
			vim.lsp.config.terraformls = {
				capabilities = capabilities,
			}

			vim.lsp.enable({ "pyright", "lua_ls", "tsserver", "tailwindcss", "sqlls", "terraformls" })
			-- Global mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
			--vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
			--vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
			vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
					--vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
					--vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
					--vim.keymap.set('n', '<leader>wl', function()
					--print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					-- end,opts)
					--vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
					--vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
					--vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
					--vim.keymap.set('n', '<leader>f', function()
					--  vim.lsp.buf.format { async = true }
					-- end, opts)
				end,
			})
		end,
	},
}
