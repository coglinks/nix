local ls = require'luasnip'
local s = ls.s
local i = ls.insert_node
local t = ls.text_node

ls.snippets = {
  markdown = {
    s("beg", {
      t("\\begin{"), i(1, "environment"), t("}"),
      i(0),
      t({"\\end{", ""}), i(1), t("}"),
    }),

    -- \frac{numerator}{denominator}
    s("frac", {
      t("\\frac{"), i(1, "numerator"), t("}{"), i(2, "denominator"), t("}"),
    }),

    -- Triggered by typing $ and expands to $$ with cursor inside
    s({ trig = "$", wordTrig = true }, {
      t("$"), i(1), t("$")
    }),
  },
}
