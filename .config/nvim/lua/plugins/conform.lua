return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" }, -- auto format trước khi save
	cmd = { "ConformInfo" }, -- lệnh kiểm tra config conform
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = false,
		-- format on save
		format_on_save = function(bufnr)
			local disable_filetypes = { c = true, cpp = true }
			if disable_filetypes[vim.bo[bufnr].filetype] then
				return nil
			end
			return { timeout_ms = 500, lsp_format = "fallback" }
		end,
		-- formatter cho từng filetype
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
			-- javascript = { "prettierd", "prettier" },
			-- typescript = { "prettierd", "prettier" },
		},
	},
}
