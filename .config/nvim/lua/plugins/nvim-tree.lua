return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },

	config = function()
		-- tắt netrw để tránh conflict
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- bật 24-bit màu (thường để chung trong options.lua, nhưng thêm ở đây cũng được)
		vim.opt.termguicolors = true

		require("nvim-tree").setup({
			hijack_cursor = true,
			sync_root_with_cwd = true,
			view = {
				adaptive_size = false,
				width = 30,
				side = "left",
			},
			renderer = {
				full_name = true,
				group_empty = true,
				special_files = {},
				symlink_destination = false,
				indent_markers = {
					enable = true,
				},
				icons = {
					git_placement = "signcolumn",
					show = {
						file = true,
						folder = true,
						folder_arrow = false,
						git = true,
					},
				},
			},
			update_focused_file = {
				enable = true,
				update_root = true,
				ignore_list = { "help" },
				update_cwd = true,
			},
			diagnostics = {
				enable = true,
				show_on_dirs = true,
			},
			filters = {
				dotfiles = false,
				git_ignored = false,
				custom = {},
			},
			actions = {
				change_dir = {
					enable = false,
					restrict_above_cwd = true,
				},
				open_file = {
					resize_window = true,
					window_picker = {
						chars = "aoeui",
					},
				},
				remove_file = {
					close_window = false,
				},
			},
			log = {
				enable = false,
				truncate = true,
				types = {
					all = false,
					config = false,
					copy_paste = false,
					diagnostics = false,
					git = false,
					profile = false,
					watcher = false,
				},
			},
		})
	end,
}
