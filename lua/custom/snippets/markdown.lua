local ls = require "luasnip"

local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("markdown", {
  s(
    "blog begin",
    fmt(
      [[---
title: {}
date: {}
prev: {}
next: {}
---
]],
      { i(1), i(2), i(3), i(0) }
    )
  ),
})
