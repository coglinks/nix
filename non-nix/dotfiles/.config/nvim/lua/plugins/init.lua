return {
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>gi", "<cmd>LazyGit<cr>", desc = "Open lazy git" },
    },
  },
---@type LazySpec
{
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  dependencies = { "folke/snacks.nvim", lazy = true },
  keys = {
    -- 👇 in this section, choose your own keymappings!
    {
      "<leader>-",
      mode = { "n", "v" },
      "<cmd>Yazi<cr>",
      desc = "Open yazi at the current file",
    },
    {
      -- Open in the current working directory
      "<leader>cw",
      "<cmd>Yazi cwd<cr>",
      desc = "Open the file manager in nvim's working directory",
    },
    {
      "<c-up>",
      "<cmd>Yazi toggle<cr>",
      desc = "Resume the last yazi session",
    },
  },
  ---@type YaziConfig | {}
  opts = {
    -- if you want to open yazi instead of netrw, see below for more info
    open_for_directories = false,
    keymaps = {
      show_help = "<f1>",
    },
  },
  -- 👇 if you use `open_for_directories=true`, this is recommended
  init = function()
    -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
    -- vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
},
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "lambdalisue/vim-suda",
    lazy = false
  },
  -- plugins/quarto.lua
  {
    {
      "quarto-dev/quarto-nvim",
      dependencies = {
        "jmbuhr/otter.nvim",
        "nvim-treesitter/nvim-treesitter",
      },
    },
  },

  {
      'jmbuhr/otter.nvim',
      dependencies = {
        'nvim-treesitter/nvim-treesitter',
      },
      opts = {},
  },

-- {
--  "sirver/ultisnips",
--  event = "InsertEnter",
--  config = function()
--    vim.g.UltiSnipsExpandTrigger = "<tab>"
--    vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
--    vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"
--    vim.g.python3_host_prog = "/usr/bin/python3"
--  end,
--  },

  {
  "dense-analysis/ale",
  event = "VeryLazy",
  config = function()
    vim.g.ale_linters = {
      tex = { "chktex", "lacheck" },
      latex = { "chktex", "lacheck" },
    }
    vim.g.ale_fixers = {
      tex = { "latexindent" },
      latex = { "latexindent" },
    }
    vim.g.ale_latex_chktex_options = "-wall" -- Enable all warnings
    vim.g.ale_lint_on_text_changed = "never"
    vim.g.ale_lint_on_insert_leave = 1
    vim.g.ale_lint_on_save = 1
    vim.g.ale_fix_on_save = 1
  end
  },

  -- These are some examples, uncomment them if you want to see them work!

{
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
    vim.g.vimtex_include_patterns = { '*.tex', '*.sty'}
    vim.g.vimtex_filetypes = {'tex'}

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
},

   {
   	"nvim-treesitter/nvim-treesitter",
   	opts = {
   		ensure_installed = {
   			"vim", "lua", "vimdoc",
        "html", "css"
   		},
   	},
   },
}
