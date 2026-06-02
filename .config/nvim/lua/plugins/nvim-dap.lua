return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
		"jay-babu/mason-nvim-dap.nvim",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- UI + virtual text setup
		dapui.setup()
		require("nvim-dap-virtual-text").setup()

		-- Auto open/close UI when debugging starts/stops
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		-- Install adapters via Mason
		require("mason-nvim-dap").setup({
			ensure_installed = { "python" }, -- debugpy
			automatic_installation = true,
		})

		----------------------------------------------------------------
		-- PYTHON ADAPTER CONFIGURATION
		----------------------------------------------------------------
		local function resolve_python()
			-- Ưu tiên conda environment đang activate
			local conda_prefix = os.getenv("CONDA_PREFIX")
			if conda_prefix and conda_prefix ~= "" then
				local conda_python = conda_prefix .. "/bin/python"
				if vim.fn.executable(conda_python) == 1 then
					return conda_python
				end
			end

			-- Kiểm tra virtual environment
			local venv = os.getenv("VIRTUAL_ENV")
			if venv and venv ~= "" then
				local venv_python = venv .. "/bin/python"
				if vim.fn.executable(venv_python) == 1 then
					return venv_python
				end
			end

			-- Fallback to system python
			local py3 = vim.fn.exepath("python3")
			if py3 ~= "" then
				return py3
			end

			return "python"
		end

		dap.adapters.python = {
			type = "executable",
			command = resolve_python(),
			args = { "-m", "debugpy.adapter" },
		}

		----------------------------------------------------------------
		-- PYTHON DEBUG CONFIGURATIONS
		----------------------------------------------------------------
		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Launch current file",
				program = "${file}",
				console = "integratedTerminal",
				justMyCode = false,
				pythonPath = resolve_python,
			},
		}
	end,
}
