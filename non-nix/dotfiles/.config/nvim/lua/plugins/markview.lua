return {
	"OXY2DEV/markview.nvim",
	lazy = false,
	dependencies = {
		 "saghen/blink.cmp"
	},
	keys = {
		{ '<leader>Ms', function()
			local status = vim.g.markview_enabled
			if status then
				vim.cmd("Markview disable")
			else
				vim.cmd("Markview enable")
			end
			vim.g.markview_enabled = not status
		end , desc = 'Markview Disable' }
	}
}
