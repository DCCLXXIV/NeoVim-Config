-- 📌 Podstawowe ustawienia Neovim
vim.opt.number = true              -- Numery linii
vim.opt.relativenumber = true      -- Relatywne numery linii
vim.opt.tabstop = 4                -- Długość tabulacji
vim.opt.shiftwidth = 4             -- Wcięcia kodu
vim.opt.softtabstop = 4            -- Tab w trybie Insert przesuwa o 4 spacje
vim.opt.expandtab = true           -- Konwersja tabów na spacje
vim.opt.autoindent = true          -- Automatyczne wcięcia
vim.opt.termguicolors = true       -- Obsługa kolorów w terminalu
vim.opt.clipboard = "unnamedplus"  -- Schowek systemowy
vim.opt.cursorline = true          -- Podświetlenie linii kursora
vim.opt.scrolloff = 8              -- Zachowaj 8 linii kontekstu podczas przewijania
vim.opt.signcolumn = "yes"         -- Zawsze pokazuj kolumnę na znaki (np. Git, LSP)
vim.o.winborder = "none"

vim.g.mapleader = "\\"
vim.g.maplocalleader = " "

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("four_space_indentation", { clear = true }),
	pattern = { "c", "cpp", "java" },
	callback = function()
		vim.bo.tabstop = 4
		vim.bo.shiftwidth = 4
		vim.bo.softtabstop = 4
		vim.bo.expandtab = true
	end,
})
