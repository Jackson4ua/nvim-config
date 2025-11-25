return {
  "akinsho/bufferline.nvim",
  opts = {
    options = {
      separator_style = "slope",
      groups = {
        options = {
          toggle_hidden_on_enter = true,
        },
        items = {
          {
            name = "Api",
            icon = "",
            matcher = function(buf)
              return buf.path and buf.path:match("/Api/")
            end,
            separator = { -- Optional
              style = require("bufferline.groups").separator.tab,
            },
          },
          {
            name = "App",
            icon = "",
            matcher = function(buf)
              return buf.path and buf.path:match("/App/")
            end,
            separator = { -- Optional
              style = require("bufferline.groups").separator.tab,
            },
          },
        },
      },
    },
  },
}
