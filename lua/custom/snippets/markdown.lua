local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

-- Helper function for current date
local function get_date()
  return { os.date("%Y-%m-%d") }
end

ls.add_snippets("markdown", {
  s(
    "blog begin",
    fmt(
      [[---
title: {}
date: {}
prev: {}
next: {}
tags: [{}]
draft: {}
---

{}
]],
      {
        i(1, "Post Title"), -- Placeholder text for title
        f(get_date, {}),    -- Automatically populates today's date
        i(2, "false"),      -- prev slug/title
        i(3, "false"),      -- next slug/title
        i(4, ""),           -- tags
        i(5, "false"),      -- draft
        i(0),               -- Final cursor jump location (body)
      }
    )
  ),
})
