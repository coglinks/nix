return {
  {
    "CRAG666/code_runner.nvim",
    config = function ()
      require('code_runner').setup({
        filetype = {
          java = {
            "cd $dir &&",
            "javac $fileName &&",
            "java $fileNameWithoutExt"
          },
          python = "python3 -u",
          typescript = "deno run",
          rust = {
            "cd $dir &&",
            "rustc $fileName &&",
            "$dir/$fileNameWithoutExt"
          },
          c = function(...)
            c_base = {
              "cd $dir &&",
              "gcc $fileName -o",
              "/tmp/$fileNameWithoutExt",
            }
            local c_exec = {
              "&& /tmp/$fileNameWithoutExt &&",
              "rm /tmp/$fileNameWithoutExt",
            }
            vim.ui.input({ prompt = "Add more args:" }, function(input)
              c_base[4] = input
              vim.print(vim.tbl_extend("force", c_base, c_exec))
              require("code_runner.commands").run_from_fn(vim.list_extend(c_base, c_exec))
            end)
          end,
        },
      })
      vim.keymap.set('n', '<leader>rr', ':RunCode<CR>', { noremap = true, silent = false })
      vim.keymap.set('n', '<leader>rf', ':RunFile<CR>', { noremap = true, silent = false })
      vim.keymap.set('n', '<leader>rft', ':RunFile tab<CR>', { noremap = true, silent = false })
      vim.keymap.set('n', '<leader>rp', ':RunProject<CR>', { noremap = true, silent = false })
      vim.keymap.set('n', '<leader>rc', ':RunClose<CR>', { noremap = true, silent = false })
      vim.keymap.set('n', '<leader>crf', ':CRFiletype<CR>', { noremap = true, silent = false })
      vim.keymap.set('n', '<leader>crp', ':CRProjects<CR>', { noremap = true, silent = false })
    end,
  },
  {
    "Kurama622/markdown-org",
    ft = "markdown",
    config = function()
      vim.g.language_path = {
        python = "python",
        python3 = "python3",
        go = "go",
        c = "gcc -Wall",
        cpp = "g++ -std=c++11 -Wall",
        bash = "bash",
        ["c++"] = "g++ -std=c++11 -Wall",
      }
      return {
        default_quick_keys = 0,
        vim.api.nvim_set_var("org#style#border", 2),
        vim.api.nvim_set_var("org#style#bordercolor", "FloatBorder"),
        vim.api.nvim_set_var("org#style#color", "String"),
      }
    end,
    keys = {
      { "<leader>mr", "<cmd>call org#main#runCodeBlock()<cr>", desc = "Run Code Block" },
      { "<leader>ml", "<cmd>call org#main#runLanguage()<cr>", desc = "Run Lang" },
    },
  }
}
