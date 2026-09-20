return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre", "BufNewFile" },
		cmd = { "ConformInfo" },
		opts = {
			formatters = {
				["clang-format"] = {
					args = {
						"--style=file",
						"--fallback-style=" .. vim.json.encode({
							BasedOnStyle = "LLVM",
							IndentWidth = 4,
							TabWidth = 4,
							UseTab = "Never",
							ColumnLimit = 120,
							PointerAlignment = "Left",
							SortIncludes = false,
							IndentCaseLabels = true,
							NamespaceIndentation = "All",
							SeparateDefinitionBlocks = "Always",
							IndentAccessModifiers = false,
							AccessModifierOffset = -4,
							AllowShortFunctionsOnASingleLine = "None",
							BreakBeforeBraces = "Custom",
							BraceWrapping = {
								AfterClass = true,
								AfterFunction = true,
								AfterNamespace = true,
								AfterStruct = false,
								AfterEnum = false,
								AfterControlStatement = "Always",
								AfterCaseLabel = true,
								BeforeCatch = true,
								BeforeElse = true,
							},
						}),
					},
				},
			},
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				vue = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				python = { "black" },
				rust = { "rustfmt" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				java = { "google-java-format" },
			},

			format_on_save = {
				timeout_ms = 1000,
				lsp_fallback = true,
			},
		},

		init = function()
			vim.keymap.set({ "n", "v" }, "<leader>f", function()
				require("conform").format({ async = true, lsp_fallback = true })
			end, { desc = "Format file or selection" })
		end,
	},
}
