local M = {}

M.capabilities = require("cmp_nvim_lsp").default_capabilities()

function M.on_attach(_, bufnr)
	local opts = { buffer = bufnr, noremap = true, silent = true }
	local map = function(lhs, rhs, desc)
		vim.keymap.set("n", lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
	end

	map("gd", vim.lsp.buf.definition, "LSP: Go to definition")
	map("gr", vim.lsp.buf.references, "LSP: List references")
	map("K", vim.lsp.buf.hover, "LSP: Documentation")
	map("<leader>ca", vim.lsp.buf.code_action, "LSP: Code action")
	map("<leader>rn", vim.lsp.buf.rename, "LSP: Rename")
end

return M
