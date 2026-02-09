return {
  "neo451/feed.nvim",
  cmd = "Feed",
  ---@module 'feed'
  ---@type feed.config
  opts = {
    feeds = {
      {
        "https://www.nytimes.com/athletic/rss/premier-league/",
        name = "Athletic - Premier League",
        tags = { "sports" },
      },
    },
  },
}
