-- Dedykowany plik dla całej konfiguracji LSP, nvim-cmp i powiązanych wtyczek
return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",

			{
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				opts = {
					ensure_installed = {
						"stylua",
						"prettier",
						"clang-format",
						"google-java-format",
						"java-debug-adapter",
						"java-test",
						"black",
					},
				},
			},
		},
		config = function()
			local lsp = require("config.lsp")

			require("mason").setup()

			require("mason-lspconfig").setup({
				ensure_installed = {
					"clangd",
					"pyright",
					"html",
					"cssls",
					"jdtls",
					"ts_ls",
					"rust_analyzer",
					"lua_ls",
				},
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({
							on_attach = lsp.on_attach,
							capabilities = lsp.capabilities,
						})
					end,

					["clangd"] = function()
						require("lspconfig").clangd.setup({
							on_attach = lsp.on_attach,
							capabilities = lsp.capabilities,
							cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
							root_dir = require("lspconfig.util").root_pattern(
								"compile_commands.json",
								"compile_flags.txt",
								".clangd",
								".git"
							),
						})
					end,

					["jdtls"] = function() end,

					["lua_ls"] = function()
						require("lspconfig").lua_ls.setup({
							on_attach = lsp.on_attach,
							capabilities = lsp.capabilities,
							settings = {
								Lua = {
									runtime = { version = "LuaJIT" },
									diagnostics = { globals = { "vim" } },
									workspace = { library = vim.api.nvim_get_runtime_file("", true) },
								},
							},
						})
					end,

					["rust_analyzer"] = function()
						require("lspconfig").rust_analyzer.setup({
							on_attach = lsp.on_attach,
							capabilities = lsp.capabilities,
							settings = {
								["rust-analyzer"] = {
									cargo = { allFeatures = true },
									checkOnSave = { command = "clippy" },
								},
							},
						})
					end,
				},
			})

			local cmp = require("cmp")
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},
}
