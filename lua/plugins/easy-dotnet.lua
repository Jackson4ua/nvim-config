return {
  "GustavEikaas/easy-dotnet.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim", "akinsho/toggleterm.nvim" },
  config = function()
    local dotnet = require("easy-dotnet")
    require("easy-dotnet").setup({
      lsp = {
        enabled = true, -- Enable builtin roslyn lsp
        roslynator_enabled = true, -- Automatically enable roslynator analyzer
        easy_dotnet_analyzer_enabled = true, -- Enable roslyn analyzer from easy-dotnet-server
        config = {},
      },
      picker = "snacks",
    })
    require("easy-dotnet.netcoredbg").register_dap_variables_viewer()
    vim.keymap.set("n", "<leader>dd", function()
      dotnet.debug_profile()
    end, { desc = "Dotnet Debug" })

    vim.keymap.set("n", "<leader>dh", function()
      local Terminal = require("toggleterm.terminal").Terminal

      -- 🔍 find .slnx root
      local function find_slnx_root()
        local dir = vim.fn.expand("%:p:h")

        while dir ~= "" do
          if vim.fn.glob(dir .. "/*.slnx") ~= "" then
            return dir
          end
          local parent = vim.fn.fnamemodify(dir, ":h")
          if parent == dir then
            break
          end
          dir = parent
        end

        return nil
      end

      local root = find_slnx_root()

      if not root then
        vim.notify("No .slnx found", vim.log.levels.ERROR)
        return
      end

      -- 🔍 find .csproj (safe version)
      local projects = vim.fn.glob(root .. "/**/*.csproj", true, true)

      if #projects == 0 then
        vim.notify("No .csproj found", vim.log.levels.ERROR)
        return
      end

      local csproj = projects[1]

      -- 🧠 reuse terminal per root
      _G.dotnet_terms = _G.dotnet_terms or {}

      if not _G.dotnet_terms[root] then
        _G.dotnet_terms[root] = Terminal:new({
          cmd = 'cd /d "' .. root .. '" && dotnet watch --project "' .. csproj .. '"',
          direction = "horizontal",
          size = 10,
          hidden = true,
        })
      end

      _G.dotnet_terms[root]:toggle()
    end, { desc = "Toggle dotnet watch" })

    vim.keymap.set(
      "t",
      "<leader>dh",
      [[<C-\><C-n><cmd>lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<leader>dh", true, false, true), "n", true)<CR>]],
      { desc = "Toggle dotnet watch" }
    )
  end,
}
