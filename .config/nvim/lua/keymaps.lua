vim.g.mapleader = " "
vim.g.localmapleader = " "

-- Keymaps for Neovim
-- Quản lý tập trung ở đây, đơn giản dễ nhớ

local map = vim.keymap.set

-- [[ Cơ bản ]]
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- [[ Di chuyển cửa sổ ]]
map("n", "<C-h>", "<C-w><C-h>", { desc = "[W]indow Left" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "[W]indow Right" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "[W]indow Down" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "[W]indow Up" })

-- [[ NvimTree ]]
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "[T]oggle File [E]xplorer" })

-- [[ Telescope ]]
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "[F]ind [F]iles" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "[F]ind by [G]rep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "[F]ind [B]uffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "[F]ind [H]elp" })

-- [[ LSP ]]
map("n", "gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
map("n", "gr", vim.lsp.buf.references, { desc = "[G]oto [R]eferences" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev [D]iagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next [D]iagnostic" })
map("n", "<leader>l", vim.diagnostic.open_float, { desc = "[L]ine Diagnostics" })

-- [[ Formatting (conform.nvim) ]]
map("n", "<leader>f", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "[F]ormat Buffer" })

-- [[ Debug (DAP) ]]
map("n", "<leader>ds", function()
	require("dap").continue()
end, { desc = "[D]ebug [S]tart/Continue" })
map("n", "<leader>do", function()
	require("dap").step_over()
end, { desc = "[D]ebug Step [O]ver" })
map("n", "<leader>di", function()
	require("dap").step_into()
end, { desc = "[D]ebug Step [I]nto" })
map("n", "<leader>dO", function()
	require("dap").step_out()
end, { desc = "[D]ebug Step [O]ut" })
map("n", "<leader>db", function()
	require("dap").toggle_breakpoint()
end, { desc = "[D]ebug [B]reakpoint" })
map("n", "<leader>du", function()
	require("dapui").toggle()
end, { desc = "[D]ebug Toggle [U]I" })
map("n", "<leader>dr", function()
	require("dap").restart()
end, { desc = "[D]ebug [R]estart" })

-- Visual mode: Move selected lines up/down với Shift+K/Shift+J
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
