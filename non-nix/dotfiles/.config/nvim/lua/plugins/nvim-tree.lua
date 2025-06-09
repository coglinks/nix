return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    vim.keymap.set('n', '<leader>e', ':NvimTreeOpen<CR>', { desc = "Open nvim-tree", silent = true })

    require("nvim-tree").setup {
      -- your nvim-tree options here
    }
  end,
}

