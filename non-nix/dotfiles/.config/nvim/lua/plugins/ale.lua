return {
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
  }
}
