return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre", "BufNewFile" },
		cmd = { "ConformInfo" },
		opts = {
			formatters = {
				clang_format_system = {
					command = "/usr/bin/clang-format",
					args = {
						"--style=" .. vim.json.encode({
							BasedOnStyle = "LLVM",
							IndentWidth = 4,
							AccessModifierOffset = -4,
							IndentAccessModifiers = false,
							TabWidth = 4,
							UseTab = "Never",
							ColumnLimit = 120,
							PointerAlignment = "Left",
							BreakBeforeBraces = "Custom",
							SortIncludes = false,
							IndentCaseLabels = true,
							NamespaceIndentation = "All",
							SeparateDefinitionBlocks = "Always",
							RemoveBracesLLVM = true,
							RemoveEmptyLinesInUnwrappedLines = true,
							AllowShortFunctionsOnASingleLine = "All",
							BinPackArguments = false,
							BinPackParameters = false,
							BraceWrapping = {
								AfterClass = true,
								AfterFunction = true,
								AfterNamespace = true,
								AfterStruct = false,
								AfterEnum = false,
								AfterControlStatement = true,
								BeforeCatch = true,
								BeforeElse = true,
								AfterCaseLabel = true,
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
				c = { "clang_format_system" },
				cpp = { "clang_format_system" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		},
		init = function()
			vim.keymap.set({ "n", "v" }, "<leader>f", function()
				require("conform").format({ async = true, lsp_fallback = true })
			end, { desc = "Formatuj plik lub zaznaczenie" })
		end,
	},
}
