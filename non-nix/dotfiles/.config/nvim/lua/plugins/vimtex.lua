return {
	'lervag/vimtex',
	ft = {'tex'},  -- Load only for .tex files
	config = function()
		vim.g.vimtex_view_method = 'zathura'
		vim.g.vimtex_quickfix_mode = 0
		vim.o.conceallevel = 1
		vim.g.tex_conceal = 'abdmg'
		vim.g.vimtex_matchparen_enabled = 1
		vim.g.vimtex_syntax_enabled = 1
		vim.g.vimtex_syntax_conceal_disable = 0
		vim.g.vimtex_include_patterns = { '*.tex', '*.sty' }
		vim.g.vimtex_filetypes = {'tex' }

		-- Use latexmk for compilation
		vim.g.vimtex_compiler_method = 'latexmk'
		vim.g.vimtex_compiler_latexmk = {
			options = {
				'-pdf',
				'-synctex=1',
				'-interaction=nonstopmode',
				'-shell-escape',
			},
		}

		-- Fix SyncTeX for Zathura in Hyprland
		vim.g.vimtex_view_general_options = '--synctex-forward @line:@col:@pdf --unique'
	end
}
