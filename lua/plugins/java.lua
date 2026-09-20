return {
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			local jdtls = require("jdtls")
			local root_dir = jdtls.setup.find_root({ "mvnw", "gradlew", "pom.xml", "build.gradle", "build.gradle.kts", ".git" })
			if not root_dir then
				return
			end

			local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
			local bundles = vim.split(
				vim.fn.glob(mason_packages .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"),
				"\n",
				{ trimempty = true }
			)
			vim.list_extend(
				bundles,
				vim.split(vim.fn.glob(mason_packages .. "/java-test/extension/server/*.jar"), "\n", { trimempty = true })
			)

			jdtls.start_or_attach({
				cmd = { "jdtls" },
				root_dir = root_dir,
				capabilities = require("config.lsp").capabilities,
				on_attach = require("config.lsp").on_attach,
				init_options = { bundles = bundles },
				settings = {
					java = {
						configuration = { updateBuildConfiguration = "interactive" },
						eclipse = { downloadSources = true },
						maven = { downloadSources = true },
						references = { includeDecompiledSources = true },
						implementationsCodeLens = { enabled = true },
						referencesCodeLens = { enabled = true },
						saveActions = { organizeImports = true },
						format = { enabled = true },
					},
				},
			})
		end,
	},
}
