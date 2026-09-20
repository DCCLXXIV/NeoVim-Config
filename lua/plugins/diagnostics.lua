return {
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics list" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
		},
		opts = {},
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "LspAttach",
		priority = 1000,
		config = function()
			vim.diagnostic.config({
				virtual_text = false,
				float = { border = "none" },
			})
			require("tiny-inline-diagnostic").setup({
				options = {
					show_source = true,
					multilines = { enabled = true, always_show = false },
				},
			})
		end,
	},
}
