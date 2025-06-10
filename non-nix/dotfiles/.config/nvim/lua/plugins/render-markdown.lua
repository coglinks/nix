return {
	'MeanderingProgrammer/render-markdown.nvim',
	dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {},
	config = function()
		require('render-markdown').setup({
				completions = { lsp = { enabled = true } },
		})
		local function switch_to_markdown()
			if not switch_filetype then
				return
			end
			vim.cmd(":set filetype=markdown")
			update_nabla_virtual();
		end

		local function switch_to_tex()
			if not switch_filetype then
				return
			end
			vim.cmd(":set filetype=tex")
		end
		vim.api.nvim_create_autocmd("InsertEnter", { pattern = "*.md", callback = switch_to_tex })
		vim.api.nvim_create_autocmd("InsertLeave", { pattern = "*.md", callback = switch_to_markdown })
	end
}
