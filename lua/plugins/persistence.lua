return {
  "folke/persistence.nvim",
  lazy = false, -- Force load on startup so the autocmd can fire
  opts = {
    -- Your existing options
    dir = vim.fn.stdpath("state") .. "/sessions/",
    options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" },
  },
  config = function(_, opts)
    require("persistence").setup(opts)
    local group = vim.api.nvim_create_augroup("PersistenceAutoLoad", { clear = true })
    vim.api.nvim_create_autocmd("VimEnter", {
      group = group,
      callback = function()
        if vim.fn.argc() == 0 and not vim.g.started_with_stdin then
          require("persistence").load()
          vim.schedule(function()
            vim.cmd("silent! e")
          end)
        end
      end,
      nested = true,
    })
  end,
}
