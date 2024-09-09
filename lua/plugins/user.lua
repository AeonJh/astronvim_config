-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  -- Commented because of https://github.com/andweeb/presence.nvim/issues/150
  -- And I think it's not useful for me.
  -- "andweeb/presence.nvim",

  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

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
    config = function ()
      require('neoscroll').setup {}
    end
  },

  {
    "m4xshen/hardtime.nvim",
    enabled = false, -- disable by default
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    config = function() require("hardtime").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        " █████  ███████ ████████ ██████   ██████",
        "██   ██ ██         ██    ██   ██ ██    ██",
        "███████ ███████    ██    ██████  ██    ██",
        "██   ██      ██    ██    ██   ██ ██    ██",
        "██   ██ ███████    ██    ██   ██  ██████",
        " ",
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
      }
      return opts
    end,
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
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
      },
    },
    keys = {
      {
        "<leader>fA",
        "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
        desc = "live_grep_args (root dir)",
      },
    },
    config = function(_, opts)
      local telescope = require "telescope"
      telescope.setup(opts)
      telescope.load_extension "live_grep_args"
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
      require("noice").setup {
        -- your noice config goes here
        lsp = {
          signature = { enabled = false, },
          hover = { enabled = false, },
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

  -- {
  --   "3rd/image.nvim",
  --   config = function()
  --       -- ...
  --   end
  -- },


  {
    "JuanZoran/Trans.nvim",
    build = function () require'Trans'.install() end,
    -- config = function(_, opts)
    --   require("Trans").setup(opts) {
    --     frontend = {
    --       hover = {
    --         keymaps = {
    --             pageup       = '[[',
    --             pagedown     = ']]',
    --             pin          = '<leader>[',
    --             close        = '<leader>]',
    --             toggle_entry = '<leader>;',
    --         },
    --       },
    --     },
    --   }
    -- end,
    keys = {
        -- you can add keybindings here
        { 'mm', mode = { 'n', 'x' }, '<Cmd>Translate<CR>', desc = '󰊿 Translate' },
        { 'mk', mode = { 'n', 'x' }, '<Cmd>TransPlay<CR>', desc = ' Auto Play' },
        -- At present, the window of this function is not ready, you can change the view.i to hover in the configuration
        { 'mi', '<Cmd>TranslateInput<CR>', desc = '󰊿 Translate From Input' },
    },
    dependencies = { 'kkharji/sqlite.lua', },
    opts = {
        -- your configuration there
    }
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.cmd [[Lazy load markdown-preview.nvim]]
      vim.fn['mkdp#util#install']()
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
}
