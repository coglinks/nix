--[[  NOTE: Source: https://github.com/linkarzu/dotfiles-latest/blob/4ac00c8653025da331d43adfb892dc7a67ea4c6a/neovim/nvim-lazyvim/lua/config/keymaps.lua

This is edited to match linux 
Delete image file under cursor (linux) --]]
return {
	-- Refresh the images in the current buffer
	-- Useful if you delete an actual image file and want to see the changes
	-- without having to re-open neovim
	vim.keymap.set("n", "<leader>ir", function()
		-- First I clear the images
		-- I'm using [[ ]] to escape the special characters in a command
		vim.cmd([[lua require("image").clear()]])
		-- Reloads the file to reflect the changes
		vim.cmd("edit!")
		print("Images refreshed")
	end, { desc = "Refresh images" })
}
