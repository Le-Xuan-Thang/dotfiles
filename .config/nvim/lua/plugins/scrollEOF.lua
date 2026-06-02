return {
	"Aasim-A/scrollEOF.nvim",
	config = function()
		require("scrollEOF").setup({
			event = { "CursorMoved", "WinScrolled" },
			opt = {
				insert_mode = true,
				disabled_filetypes = {
					"snacks_terminal", --fix flickering in Lazygit and terminals
				},
			},
		})
	end,
}
