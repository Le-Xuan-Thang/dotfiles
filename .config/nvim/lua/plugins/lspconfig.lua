-- lspconfig.lua
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		-- Allows extra capabilities provided by blink.cmp
		-- "saghen/blink.cmp",
		"hrsh7th/nvim-cmp",
	},
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local servers = {
			pyright = {
				filetypes = { "python" },
				settings = {
					python = {
						pythonPath = vim.fn.exepath("python"), -- 🎯 Đây là phần fix!
						analysis = {
							autoSearchPaths = true,
							diagnosticMode = "openFilesOnly",
							useLibraryCodeForTypes = true,
						},
					},
				},
			},
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
    diagnostics = { globals = { "vim" } },
					},
				},
			},
		}

		-- Setup mason-tool-installer
		local ensure_installed = vim.tbl_keys(servers or {})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		-- Setup mason-lspconfig
		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
