-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  {
    "p00f/clangd_extensions.nvim", -- install lsp plugin
    lazy = true,
    init = function()
      -- load clangd extensions when clangd attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "Load clangd_extensions with clangd",
        callback = function(args)
          if
            assert(vim.lsp.get_client_by_id(args.data.client_id)).name
            == "clangd"
          then
            require("clangd_extensions")
            -- add more `clangd` setup here as needed such as loading autocmds
            return true -- delete the autocommand once the plugin is loaded
          end
        end,
      })
    end,
    keys = {
      { "<leader>lw", mode = { "n", "x" }, "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch source/header" },
    },
  },
  -- {
  --   "WhoIsSethDaniel/mason-tool-installer.nvim",
  --   opts = {
  --     ensure_installed = { "clangd" }, -- automatically install lsp
  --   },
  -- },
}
