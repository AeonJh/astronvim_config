-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize dashboard options
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = table.concat({
            " █████  ███████ ████████ ██████   ██████ ",
            "██   ██ ██         ██    ██   ██ ██    ██",
            "███████ ███████    ██    ██████  ██    ██",
            "██   ██      ██    ██    ██   ██ ██    ██",
            "██   ██ ███████    ██    ██   ██  ██████ ",
            "",
            "███    ██ ██    ██ ██ ███    ███",
            "████   ██ ██    ██ ██ ████  ████",
            "██ ██  ██ ██    ██ ██ ██ ████ ██",
            "██  ██ ██  ██  ██  ██ ██  ██  ██",
            "██   ████   ████   ██ ██      ██",
          }, "\n"),
        },
      },
    },
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = true },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },

  -- == User added plugins ==
  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle", -- optional for lazy loading on command
    event = { "InsertLeave" }, -- optional for lazy loading on trigger events
    keys = {
      { "<leader>N", ":ASToggle<CR>", desc = "Toggle auto-save" },
    },
    opts = {
      -- your config goes here
      -- or just leave it empty :)
    },
  },

  {
    "lambdalisue/suda.vim",
    lazy = true,
    keys = {
      { "<leader>W", ":SudaWrite<CR>", desc = "Write with sudo" },
      { "<leader>R", ":SudaRead<CR>", desc = "Read with sudo" },
    },
  },

  {
    "karb94/neoscroll.nvim",
    enabled = false, -- disable by default
    config = function() require("neoscroll").setup {} end,
  },

  {
    "m4xshen/hardtime.nvim",
    enabled = false, -- disable by default
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    config = function() require("hardtime").setup() end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
      require("noice").setup {
        -- your noice config goes here
        lsp = {
          signature = { enabled = false },
          hover = { enabled = false },
        },
      }
    end,
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  },

  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>-",
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        -- Open in the current working directory
        "<leader>cw",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
      {
        -- NOTE: this requires a version of yazi that includes
        -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
        "<c-up>",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
      },
      ---@diagnostic disable-next-line: missing-fields
      hooks = {
        ---@diagnostic disable-next-line: unused-local
        yazi_opened = function(_preselected_path, buffer, _config) vim.cmd "set timeoutlen=0" end,
        ---@diagnostic disable-next-line: unused-local
        yazi_closed_successfully = function(_preselected_path, _buffer, _config) vim.cmd "set timeoutlen=500" end,
      },
    },
  },

  {
    "JuanZoran/Trans.nvim",
    build = function() require("Trans").install() end,
    keys = {
      -- you can add keybindings here
      { "mm", mode = { "n", "x" }, "<Cmd>Translate<CR>", desc = "󰊿 Translate" },
      { "mk", mode = { "n", "x" }, "<Cmd>TransPlay<CR>", desc = " Auto Play" },
      -- At present, the window of this function is not ready, you can change the view.i to hover in the configuration
      { "mi", "<Cmd>TranslateInput<CR>", desc = "󰊿 Translate From Input" },
    },
    dependencies = { "kkharji/sqlite.lua" },
    opts = {
      -- your configuration there
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  },

  {
    "ggandor/leap.nvim",
    opts = {
      equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" },
    },
    dependencies = { "tpope/vim-repeat" },
    keys = {
      { "f", mode = { "n" }, "<Plug>(leap)" },
      { "F", mode = { "n" }, "<Plug>(leap-from-window)" },
      { "f", mode = { "x", "o" }, "<Plug>(leap-forward)" },
      { "F", mode = { "x", "o" }, "<Plug>(leap-backward)" },
    },
  },

  {
    "sindrets/diffview.nvim",
    enabled = false,
    event = "BufEnter",
    keys = {
      { "<leader>gL", mode = { "n" }, "<Cmd>DiffviewFileHistory<CR>", desc = "Open DiffView File History" },
    },
  },

  {
    "rmagatti/goto-preview",
    event = "BufEnter",
    config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
    keys = {
      {
        "gpd",
        mode = { "n" },
        '<Cmd>lua require("goto-preview").goto_preview_definition()<CR>',
        desc = "Goto Preview Definition",
      },
      {
        "gpt",
        mode = { "n" },
        '<Cmd>lua require("goto-preview").goto_preview_type_definition()<CR>',
        desc = "Goto Preview Type Definition",
      },
      {
        "gpi",
        mode = { "n" },
        '<Cmd>lua require("goto-preview").goto_preview_implementation()<CR>',
        desc = "Goto Preview Implementation",
      },
      {
        "gpD",
        mode = { "n" },
        '<Cmd>lua require("goto-preview").goto_preview_declaration()<CR>',
        desc = "Goto Preview Declaration",
      },
      {
        "gP",
        mode = { "n" },
        '<Cmd>lua require("goto-preview").close_all_win()<CR>',
        desc = "Close All Preview Windows",
      },
      {
        "gpr",
        mode = { "n" },
        '<Cmd>lua require("goto-preview").goto_preview_references()<CR>',
        desc = "Goto Preview References",
      },
    },
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
      model = 'claude-3.7-sonnet', -- Default model to use, see ':CopilotChatModels' for available models (can be specified manually in prompt via $).
    },

    config = function()
      -- Register copilot-chat filetype
      require('render-markdown').setup({
        file_types = { 'markdown', 'copilot-chat' },
      })

      -- Adjust chat display settings
      require('CopilotChat').setup({
        highlight_headers = false,
        separator = '---',
        error_header = '> [!ERROR] Error',
      })
    end,

    event = "VeryLazy",

    keys = {
      -- Show prompts actions with telescope
      {
        "<leader>ap",
        mode = { "n", "x" },
        function()
          require("CopilotChat").select_prompt()
        end,
        desc = "CopilotChat - Prompt actions",
      },
      {
        "<leader>ax",
        mode = "x",
        function()
          local input = vim.fn.input("Ask Copilot: ")
          if input ~= "" then
            require("CopilotChat").ask(input, {
              selection = require("CopilotChat.select").visual,
              window = {
                layout = 'float',
                relative = 'cursor',
                width = 1,
                height = 0.4,
                row = 1
              }
            })
          end
        end,
        desc = "CopilotChat - Inline chat",
      },
      -- Custom input for CopilotChat
      {
        "<leader>ai",
        mode = "n",
        function()
          local input = vim.fn.input("Ask Copilot: ")
          if input ~= "" then
            require("CopilotChat").ask(input, {
              selection = require("CopilotChat.select").buffer,
            })
          end
        end,
        desc = "CopilotChat - Ask input",
      },
      -- Quick chat with selection
      {
        "<leader>aq",
        mode = "x",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input, {
              selection = require("CopilotChat.select").buffer
            })
          end
        end,
        desc = "CopilotChat - Quick chat",
      },
      -- Save the chat history to file
      {
        "<leader>as",
        function()
          local input = vim.fn.input("Save chat history to file: ")
          if input == "" then return end
          local success, err = pcall(function()
            require("CopilotChat").save(input)
          end)
          if not success then
            vim.notify("Failed to save chat history: " .. err, vim.log.levels.ERROR)
          end
        end,
        desc = "CopilotChat - Save chat history",
      },
      -- Load the chat history from file
      {
        "<leader>al",
        function()
          local input = vim.fn.input("Load chat history from file: ")
          if input == "" then return end
          local success, err = pcall(function()
            require("CopilotChat").load(input)
          end)
          if not success then
            vim.notify("Failed to load chat history: " .. err, vim.log.levels.ERROR)
          end
        end,
        desc = "CopilotChat - Load chat history",
      },
      -- Fix the issue with diagnostic
      {
        "<leader>af",
        mode = { "n", "x" },
        "<cmd>CopilotChatFix<cr>",
        desc = "CopilotChat - Fix Diagnostic"
      },
      -- Toggle Copilot Chat Vsplit
      { "<leader>av", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle Vsplit" },
    },
  },
}
